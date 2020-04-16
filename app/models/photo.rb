class Photo < ApplicationRecord
  has_one_attached :image

  belongs_to :challenge
end
