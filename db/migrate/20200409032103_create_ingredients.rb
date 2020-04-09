class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.timestamps
      t.references :user, foreign_key: true
    end
  end
end
