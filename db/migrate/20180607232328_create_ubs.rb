class CreateUbs < ActiveRecord::Migration[5.2]
  def change
    create_table :ubs do |t|
      t.float :latitude
      t.float :longitude
      t.integer :cnes_code
      t.string :phone
      t.references :address, foreign_key: true
      t.string :name
      t.references :score, foreign_key: true

      t.timestamps
    end
  end
end
