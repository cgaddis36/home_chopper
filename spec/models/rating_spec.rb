require 'rails_helper'

describe Rating, type: :model do
  describe "validations" do
    it { should validate_presence_of :stars }
  end

  describe "relationships" do
    it { should belong_to :user }
    it { should belong_to :challenge }
  end
end
