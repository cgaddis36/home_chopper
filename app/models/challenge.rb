class Challenge < ApplicationRecord
  validates_presence_of :time_limit
  validates_presence_of :basket_size
  validates_presence_of :meal_type
  enum game_status: %i[before playing paused cancelled done complete]
  enum meal_type: %i[breakfast lunch dinner snack dessert]

  belongs_to :user
  has_many :challenge_ingredients
  has_many :ingredients, through: :challenge_ingredients
  has_many :ratings

  def self.three_ingredients
    where('basket_size = 3').where("game_status = '5'").order(created_at: :DESC)
  end

  def self.five_ingredients
    where('basket_size = 5').where("game_status = '5'").order(created_at: :DESC)
  end

  def self.my_three_ingredients(user)
    where('basket_size = 3').where("game_status = '5'").where("user_id = #{user.id}").order(created_at: :DESC)
  end

  def self.my_five_ingredients(user)
    where('basket_size = 5').where("game_status = '5'").where("user_id = #{user.id}").order(created_at: :DESC)
  end

  def self.top_challenges
    Challenge.joins(:ratings).group(:id).select('challenges.*, AVG(stars) AS AverageRating').order('AverageRating').limit(3)
  end

  def start_game
    update_column("game_status", "playing")
  end

  def pause_game
    update_column("game_status", "paused")
  end

  def cancel_game
    update_column("game_status", "cancelled")
  end

  def finalize_game
    update_column("game_status", "done")
  end

  def game_complete
    update_column("game_status", "complete")
  end

  def basket_contents
    contents = self.user.ingredients.sample(self.basket_size)
    contents.each do |ingredient|
      ChallengeIngredient.create(challenge_id: self.id, ingredient_id: ingredient.id)
    end
  end
<<<<<<< HEAD

  def check_rating_exists(user_id)
    Rating.where("user_id = #{user_id} and challenge_id = #{self.id}")[0]
  end

  def ave_rating
    ratings.average(:stars).to_f.round(1)
  end

  def not_mine?(id)
    self.user != User.find(id)
  end
=======
>>>>>>> 66bd00f37f993035f198270ff14e931325088a88
end
