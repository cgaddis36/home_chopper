class Challenge < ApplicationRecord
  validates_presence_of :time_limit
  validates_presence_of :basket_size
  validates_presence_of :meal_type
  enum game_status: %i[before playing paused cancelled complete]
  enum meal_type: %i[breakfast lunch dinner snack dessert]

  belongs_to :user
  has_many :challenge_ingredients
  has_many :ingredients, through: :challenge_ingredients

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
    self.update_column("game_status", "complete")
  end

  def basket_contents
    basket_pool = self.user.ingredients
    contents = basket_pool.sample(self.basket_size)
  end

end
