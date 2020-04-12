class Challenge < ApplicationRecord
  validates_presence_of :time_limit
  validates_presence_of :basket_size
  validates_presence_of :meal_type
  enum game_status: %i[before playing paused cancelled after]


  belongs_to :user
  has_many :challenge_ingredients
  has_many :ingredients, through: :challenge_ingredients
end
