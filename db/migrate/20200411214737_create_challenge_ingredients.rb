class CreateChallengeIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :challenge_ingredients do |t|
      t.references :challenge, foreign_key: true
      t.references :ingredient, foreign_key: true
    end
  end
end
