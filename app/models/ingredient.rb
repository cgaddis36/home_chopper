class Ingredient < ApplicationRecord
  validates_presence_of :name

  belongs_to :user
  has_many :challenge_ingredients
  has_many :challenges, through: :challenge_ingredients
  enum status: %i[active inactive]
end
