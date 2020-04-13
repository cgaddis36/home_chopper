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
    it { should have_many(:ingredients).through(:challenge_ingredients) }
  end

  describe 'instance methods' do
    before(:each) do
      @bob = User.create(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
      @chocolate = @bob.ingredients.create(name: "Chocolate")
      @squid = @bob.ingredients.create(name: "Squid")
      @blueberries = @bob.ingredients.create(name: "Blueberries")
      @cinnamon = @bob.ingredients.create(name: "Cinnamon")
      @eggs = @bob.ingredients.create(name: "Eggs")
      @toast = @bob.ingredients.create(name: "Toast")
      @game = @bob.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "dinner")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@bob)
    end

    it "can pick the right number of items for the mystery basket" do
      expect(@game.basket_size).to eq(3)
      expect(@bob.ingredients.count).to eq(6)
      expect(@game.basket_contents.count).to eq(3)
    end

    it "can change the challenge status to playing" do
      expect(@game.game_status).to eq("before")

      @game.start_game

      expect(@game.game_status).to eq("playing")
    end

    it "can change the challenge status to paused" do
      expect(@game.game_status).to eq("before")

      @game.pause_game

      expect(@game.game_status).to eq("paused")
    end

    it "can change the challenge status to cancelled" do
      expect(@game.game_status).to eq("before")

      @game.cancel_game

      expect(@game.game_status).to eq("cancelled")
    end

    it "can change the challenge status to complete" do
      expect(@game.game_status).to eq("before")

      @game.finalize_game

      expect(@game.game_status).to eq("done")
    end

    it "can change the challenge status to complete" do
      expect(@game.game_status).to eq("before")

      @game.game_complete

      expect(@game.game_status).to eq("complete")
    end
  end
end
