class CreateScores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores do |t|
      t.references :competitor, null: false, foreign_key: true
      t.integer :point, default: 0
      t.integer :advantage, default: 0
      t.integer :penalty, default: 0

      t.timestamps
    end
  end
end
