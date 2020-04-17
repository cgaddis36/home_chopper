class Ingredient < ApplicationRecord
  validates_presence_of :name

  belongs_to :user
  has_many :challenge_ingredients
  has_many :challenges, through: :challenge_ingredients

  def kill_join_entry
    challenge_ingredient = ChallengeIngredient.where("ingredient_id = #{self.id}")[0]
    challenge_ingredient.destroy
  end
end
