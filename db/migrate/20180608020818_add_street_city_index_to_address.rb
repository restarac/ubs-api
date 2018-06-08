class AddStreetCityIndexToAddress < ActiveRecord::Migration[5.2]
  def change
    add_index :ubs, [:street, :city]
  end
end
