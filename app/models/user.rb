class User < ApplicationRecord
has_many :ingredients
validates_presence_of :name
validates_presence_of :email

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                 = auth_info.uid
      new_user.name                = auth_info.extra.raw_info.name
      new_user.email               = auth_info.extra.raw_info.email
      new_user.google_token        = auth_info.credentials.token
    end
  end 
end
