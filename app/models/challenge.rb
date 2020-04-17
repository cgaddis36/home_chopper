class Challenge < ApplicationRecord
  validates_presence_of :time_limit
  validates_presence_of :basket_size
  validates_presence_of :meal_type
  enum game_status: %i[playing cancelled complete]
  enum meal_type: %i[breakfast lunch dinner snack dessert]

  belongs_to :user
  has_many :challenge_ingredients
  has_many :photos
  has_many :ingredients, through: :challenge_ingredients
  has_many :ratings

  def self.three_ingredients
    where('basket_size = 3').where("game_status = '2'").order(created_at: :DESC)
  end

  def self.five_ingredients
    where('basket_size = 5').where("game_status = '2'").order(created_at: :DESC)
  end

  def self.seven_ingredients
    where('basket_size = 7').where("game_status = '2'").order(created_at: :DESC)
  end

  def self.my_three_ingredients(user)
    where('basket_size = 3').where("game_status = '2'").where("user_id = #{user.id}").order(created_at: :DESC)
  end

  def self.my_five_ingredients(user)
    where('basket_size = 5').where("game_status = '2'").where("user_id = #{user.id}").order(created_at: :DESC)
  end

  def self.my_seven_ingredients(user)
    where('basket_size = 7').where("game_status = '2'").where("user_id = #{user.id}").order(created_at: :DESC)
  end

  def self.top_challenges
    Challenge.joins(:ratings).group(:id).select('challenges.*, AVG(stars) AS AverageRating').order('AverageRating').limit(3)
  end

  def cancel_game
    update_column("game_status", "cancelled")
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

  def check_rating_exists(user_id)
    Rating.where("user_id = #{user_id} and challenge_id = #{self.id}")[0]
  end

  def ave_rating
    self.ratings.average(:stars).to_f.round(1)
    ratings.average(:stars).to_f.round(1)
  end

  def not_mine?(id)
    self.user != User.find(id)
  end

  def get_ingredients_for_search
    params = {}
    ingredient_number = 0
    self.ingredients.each do |ingredient|
      params["ingredient_#{(ingredient_number += 1)}"]= ingredient.name
    end
  end
end
