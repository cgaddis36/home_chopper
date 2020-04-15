# note: this is a user/challenge joins table, to eliminate confusion, this table is called ratings.
# a challenge belongs to a user, this ratings join refers to challenges the user does
# not own.  A rating is born when a user sets a star value to ANOTHER user's challenge
class Rating < ApplicationRecord
  validates_presence_of :stars

  validates_numericality_of :stars, greater_than: 0, message: " must be greater than 0"
  validates_numericality_of :stars, lesser_than_or_equal_to: 5, message: " must be less than or equal to 5"

  belongs_to :user
  belongs_to :challenge
end
