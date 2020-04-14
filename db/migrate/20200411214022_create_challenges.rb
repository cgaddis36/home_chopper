class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.integer :time_limit
      t.integer :basket_size
      t.string :photo
      t.integer :meal_type, default: 0
      t.integer :game_status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
