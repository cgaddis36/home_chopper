require 'rails_helper'

describe ChallengeIngredient, type: :model do
  describe "validations" do
    it { should validate_presence_of :challenge_id }
    it { should validate_presence_of :ingredient_id }
  end

  describe "relationships" do
    it { should belong_to :challenge }
    it { should belong_to :ingredient }
  end
end
