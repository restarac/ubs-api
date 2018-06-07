class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.integer :size
      t.integer :adaptation_for_seniors
      t.integer :medical_equipment
      t.integer :medicine

      t.timestamps
    end
  end
end
