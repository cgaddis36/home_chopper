class Challenge < ApplicationRecord
  validates_presence_of :time_limit
  validates_presence_of :basket_size
  validates_presence_of :meal_type
  enum game_status: %i[before playing paused cancelled done complete]
  enum meal_type: %i[breakfast lunch dinner snack dessert]

  belongs_to :user
  has_many :challenge_ingredients
  has_many :ingredients, through: :challenge_ingredients

  def self.three_ingredients
    binding.pry
    where("basket_size = 3 and game_status = 'complete'").order(created_at: :DESC)
  end

  def self.five_ingredients
    binding.pry
    where("basket_size = 5 and game_status = 'complete'").order(created_at: :DESC)
  end

  def start_game
    self.update_column("game_status", "playing")
  end

  def pause_game
    self.update_column("game_status", "paused")
  end

  def cancel_game
    self.update_column("game_status", "cancelled")
  end

  def finalize_game
    self.update_column("game_status", "done")
  end

  def game_complete
    self.update_column("game_status", "complete")
  end

  def basket_contents
    contents = self.user.ingredients.sample(self.basket_size)
    contents.each do |ingredient|
      ChallengeIngredient.create(challenge_id: self.id, ingredient_id: ingredient.id)
    end
  end

  def which_ingredients
    self.ingredients
  end
end
