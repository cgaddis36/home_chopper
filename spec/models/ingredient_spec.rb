require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :challenge_ingredients }
    it { should have_many(:challenges).through(:challenge_ingredients) }
  end

  describe 'class methods' do
    before(:each) do
      @janis = User.create!(name: "Janice", email: "janice@sample.com", google_token: "678910", role: 0)
      @jelly = @janis.ingredients.create!(name: "Jelly")
      @quail_eggs = @janis.ingredients.create!(name: "Quail Eggs")
      @pears = @janis.ingredients.create!(name: "Pears")
      @jans_dessert = @janis.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "lunch", game_status: "complete")
      @challenge_ingredient = ChallengeIngredient.create!(challenge_id: @jans_dessert.id, ingredient_id: @pears.id)
    end
  end
end
