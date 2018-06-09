class AddStreetCityIndexToAddress < ActiveRecord::Migration[5.2]
  def change
    add_index :addresses, [:street, :city]
  end
end
