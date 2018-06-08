require 'csv'

class UbsImportService
  def initialize(logger, path)
    @path = path
    @logger = logger
  end

  def importAll
    CSV.foreach(@path, { headers: true }) do |row|
      begin
        attributes = {
          latitude: row["vlr_latitude"].to_f,
          longitude: row["vlr_latitude"].to_f,
          cnes_code: row["cod_cnes"].to_i,
          name: row["nom_estab"],
          phone: row["dsc_telefone"],
          score: create_score(row),
          address: first_or_initialized_address(row)
        }
        
        ubs = Ubs.new(attributes)
        ubs.save!
        
        @logger.info "Success, CNES: #{ubs.cnes_code} - #{ubs.name}"
      rescue => e
        @logger.warn "SKIPING CNES #{row["cod_cnes"]}: #{e.message}"
      end
    end
  end

  private

  def first_or_initialized_address(row)
    attributes = {
      street: row["dsc_endereco"],
      city: row["dsc_bairro"],
    }

    Address.where(attributes).first_or_initialize
  end

  SCORE_VALUES = {
    "Desempenho muito acima da média" => 3,
    "Desempenho acima da média" => 2,
    "Desempenho mediano ou  um pouco abaixo da média" => 1,
  }

  def create_score(row)
    attributes = {
      size: SCORE_VALUES[row["dsc_estrut_fisic_ambiencia"]],
      adaptation_for_seniors: SCORE_VALUES[row["dsc_adap_defic_fisic_idosos"]],
      medical_equipment: SCORE_VALUES[row["dsc_equipamentos"]],
      medicine: SCORE_VALUES[row["dsc_medicamentos"]],
    }

    Score.new(attributes)
  end
end