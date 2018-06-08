require 'logger'

namespace :import do
  desc "Imports the UBS from a file located on 'root_app/db/ubs.csv'"
  task ubs: :environment do
    log_file     = Rails.root.join("log", "#{Rails.env}.log")
    Rails.logger = ActiveSupport::Logger.new(log_file)
    Rails.logger.extend(ActiveSupport::Logger.broadcast(ActiveSupport::Logger.new(STDOUT)))

    UbsImportService.new(Rails.logger, "./db/ubs.csv").importAll
  end
end
