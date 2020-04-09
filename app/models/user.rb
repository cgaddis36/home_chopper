class User < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :email

    has_many :ingredients
end
