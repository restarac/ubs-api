class AddCnesCodeIndexToUbs < ActiveRecord::Migration[5.2]
  def change
    add_index :ubs, :cnes_code, unique: true
  end
end
