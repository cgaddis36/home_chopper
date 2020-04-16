class ChallengeIngredient < ApplicationRecord
  validates_presence_of :challenge_id
  validates_presence_of :ingredient_id

  belongs_to :challenge
  belongs_to :ingredient
end
