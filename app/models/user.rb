class User < ApplicationRecord
  has_many :ingredients
  has_many :challenges
  validates_presence_of :name
  validates_presence_of :email

  has_many :challenge_ingredients, through: :challenges

  def self.update_or_create(auth_info)
    user = User.find_by(uid: auth_info[:uid]) || User.new(user_params)
    user_params = { uid: auth_info[:uid],
                        email: auth_info[:info][:email],
                        name: auth_info[:info][:name],
                        google_token: auth_info[:credentials][:token] }
    user.save!
    user
  end
end
