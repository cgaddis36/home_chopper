class User < ApplicationRecord
  has_many :ingredients
  validates_presence_of :name
  validates_presence_of :email

  def self.update_or_create(auth_info)
    user = User.find_by(uid: auth_info[:uid]) || User.new
    user.attributes = { uid: auth_info[:uid],
                        email: auth_info[:info][:email],
                        name: auth_info[:info][:name],
                        google_token: auth_info[:credentials][:token] }
    user.save!
    user
  end
end
