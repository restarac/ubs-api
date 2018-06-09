class AddLatLongIndexToUbs < ActiveRecord::Migration[5.2]
  def change
    add_index :ubs, [:latiTude, :longitude]
  end
end
