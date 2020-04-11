require 'rails_helper'

RSpec.describe Challenge, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:time_limit) }
    it { should validate_presence_of(:basket_size) }
    it { should validate_presence_of(:meal_type) }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :challenge_ingredients }
    it {should have_many(:ingredients).through(:challenge_ingredients)}
  end
end
