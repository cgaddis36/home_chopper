require 'rails_helper'

RSpec.describe Challenge, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:time_limit) }
    it { should validate_presence_of(:basket_size) }
    it { should validate_presence_of(:meal_type) }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :ratings }
    it { should have_many :photos }
    it { should have_many :challenge_ingredients }
    it { should have_many(:ingredients).through(:challenge_ingredients) }
  end

  describe 'class methods' do
    before(:each) do
      @janis = User.create!(name: "Janice", email: "janice@sample.com", google_token: "678910", role: 0)
      @peanut_butter = @janis.ingredients.create!(name: "Peanut Butter")
      @jelly = @janis.ingredients.create!(name: "Jelly")
      @avacado = @janis.ingredients.create!(name: "Avacado")
      @lemon = @janis.ingredients.create!(name: "Lemon")
      @sprite = @janis.ingredients.create!(name: "Sprite")
      @quail_eggs = @janis.ingredients.create!(name: "Quail Eggs")
      @pears = @janis.ingredients.create!(name: "Pears")
      @bob = User.create!(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
      @chocolate = @bob.ingredients.create!(name: "Chocolate")
      @squid = @bob.ingredients.create!(name: "Squid")
      @blueberries = @bob.ingredients.create!(name: "Blueberries")
      @cinnamon = @bob.ingredients.create!(name: "Cinnamon")
      @eggs = @bob.ingredients.create!(name: "Eggs")
      @toast = @bob.ingredients.create!(name: "Toast")
      @jans_dessert = @janis.challenges.create!(time_limit: 20, basket_size: 7, meal_type: "lunch", game_status: "complete")
      ChallengeIngredient.create!(challenge_id: @jans_dessert.id, ingredient_id: @pears.id)
      ChallengeIngredient.create!(challenge_id: @jans_dessert.id, ingredient_id: @jelly.id)
      ChallengeIngredient.create!(challenge_id: @jans_dessert.id, ingredient_id: @quail_eggs.id)
      ChallengeIngredient.create!(challenge_id: @jans_dessert.id, ingredient_id: @sprite.id)
      ChallengeIngredient.create!(challenge_id: @jans_dessert.id, ingredient_id: @peanut_butter.id)
      ChallengeIngredient.create!(challenge_id: @jans_dessert.id, ingredient_id: @avacado.id)
      ChallengeIngredient.create!(challenge_id: @jans_dessert.id, ingredient_id: @lemon.id)
      @jans_snack = @janis.challenges.create!(time_limit: 20, basket_size: 7, meal_type: "lunch", game_status: "complete")
      ChallengeIngredient.create!(challenge_id: @jans_snack.id, ingredient_id: @pears.id)
      ChallengeIngredient.create!(challenge_id: @jans_snack.id, ingredient_id: @jelly.id)
      ChallengeIngredient.create!(challenge_id: @jans_snack.id, ingredient_id: @quail_eggs.id)
      ChallengeIngredient.create!(challenge_id: @jans_snack.id, ingredient_id: @sprite.id)
      ChallengeIngredient.create!(challenge_id: @jans_snack.id, ingredient_id: @peanut_butter.id)
      ChallengeIngredient.create!(challenge_id: @jans_snack.id, ingredient_id: @avacado.id)
      ChallengeIngredient.create!(challenge_id: @jans_snack.id, ingredient_id: @lemon.id)
      Rating.create!(user_id: @bob.id, challenge_id: @jans_snack.id, stars: 3)
      @jans_breakfast = @janis.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "breakfast", game_status: "complete")
      ChallengeIngredient.create!(challenge_id: @jans_breakfast.id, ingredient_id: @jelly.id)
      ChallengeIngredient.create!(challenge_id: @jans_breakfast.id, ingredient_id: @lemon.id)
      ChallengeIngredient.create!(challenge_id: @jans_breakfast.id, ingredient_id: @avacado.id)
      @jans_lunch = @janis.challenges.create!(time_limit: 20, basket_size: 5, meal_type: "lunch", game_status: "complete")
      ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @quail_eggs.id)
      ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @sprite.id)
      ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @peanut_butter.id)
      ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @avacado.id)
      ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @lemon.id)
      Rating.create!(user_id: @bob.id, challenge_id: @jans_lunch.id, stars: 3)
      @bobs_dinner = @bob.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "dinner", game_status: "complete")
      ChallengeIngredient.create!(challenge_id: @bobs_dinner.id, ingredient_id: @squid.id)
      ChallengeIngredient.create!(challenge_id: @bobs_dinner.id, ingredient_id: @blueberries.id)
      ChallengeIngredient.create!(challenge_id: @bobs_dinner.id, ingredient_id: @toast.id)
      @bobs_snack = @bob.challenges.create!(time_limit: 20, basket_size: 5, meal_type: "snack", game_status: "complete")
      ChallengeIngredient.create!(challenge_id: @bobs_snack.id, ingredient_id: @chocolate.id)
      ChallengeIngredient.create!(challenge_id: @bobs_snack.id, ingredient_id: @cinnamon.id)
      ChallengeIngredient.create!(challenge_id: @bobs_snack.id, ingredient_id: @eggs.id)
      ChallengeIngredient.create!(challenge_id: @bobs_snack.id, ingredient_id: @toast.id)
      ChallengeIngredient.create!(challenge_id: @bobs_snack.id, ingredient_id: @blueberries.id)
      @jans_second_breakfast = @janis.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "breakfast")
    end

    it ".can find all solo games with three ingredients" do
      expect(Challenge.three_ingredients.count).to eq(2)
    end

    it ".can find all solo games with five ingredients" do
      expect(Challenge.five_ingredients.count).to eq(2)
    end

    it ".can find all solo games with seven ingredients" do
      expect(Challenge.seven_ingredients.count).to eq(2)
    end

    it ".can find all solo games with three ingredients for a user" do
      expect(Challenge.my_three_ingredients(@janis).count).to eq(1)
      expect(Challenge.my_three_ingredients(@bob).count).to eq(1)
    end

    it ".can find all solo games with five ingredients for a user" do
      expect(Challenge.my_five_ingredients(@janis).count).to eq(1)
      expect(Challenge.my_five_ingredients(@bob).count).to eq(1)
    end

    it ".can find all solo games with seven ingredients for a user" do
      expect(Challenge.my_seven_ingredients(@janis).count).to eq(2)
    end
  end

  describe 'instance methods' do
    before(:each) do
      @janis = User.create!(name: "Janice", email: "janice@sample.com", google_token: "678910", role: 0)
      @bob = User.create(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
      @sally = User.create!(name: "Sally", email: "sally@sample.com", google_token: "6780", role: 0)
      @tin_lee = User.create(name: "Tin Lee", email: "tin@sample.com", google_token: "1235", role: 0)
      @chocolate = @bob.ingredients.create(name: "Chocolate")
      @squid = @bob.ingredients.create(name: "Squid")
      @blueberries = @bob.ingredients.create(name: "Blueberries")
      @cinnamon = @bob.ingredients.create(name: "Cinnamon")
      @eggs = @bob.ingredients.create(name: "Eggs")
      @toast = @bob.ingredients.create(name: "Toast")
      @game = @bob.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "dinner")
      @jans_breakfast = @janis.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "breakfast")
      @jans_lunch = @janis.challenges.create!(time_limit: 20, basket_size: 5, meal_type: "lunch")
      @rating_one = Rating.create!(user_id: @bob.id, challenge_id: @jans_breakfast.id, stars: 3)
      @rating_two = Rating.create!(user_id: @sally.id, challenge_id: @jans_breakfast.id, stars: 5)
      @rating_three = Rating.create!(user_id: @tin_lee.id, challenge_id: @jans_lunch.id, stars: 2)
      @rating_four = Rating.create!(user_id: @bob.id, challenge_id: @jans_lunch.id, stars: 5)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@bob)
    end

    it "can pick the right number of items for the mystery basket" do
      expect(@game.basket_size).to eq(3)
      expect(@bob.ingredients.count).to eq(6)
      expect(@game.basket_contents.count).to eq(3)
    end

    it "can change the challenge status to cancelled" do
      expect(@game.game_status).to eq("playing")

      @game.cancel_game

      expect(@game.game_status).to eq("cancelled")
    end

    it "can change the challenge status to complete" do
      expect(@game.game_status).to eq("playing")

      @game.game_complete

      expect(@game.game_status).to eq("complete")
    end

    it "can check to see if a user already has rated a challenge" do
      expect(@jans_breakfast.check_rating_exists(@bob.id)).to eq(@rating_one)
      expect(@game.check_rating_exists(@bob.id)).to eq(nil)
    end

    it "can find the average rating for a challenge" do
      expect(@jans_breakfast.ave_rating).to eq(4)
      expect(@jans_lunch.ave_rating).to eq(3.5)
    end

    it "can see if a challenge belongs to a user" do
      expect(@jans_breakfast.not_mine?(@bob.id)).to eq(true)
      expect(@game.not_mine?(@bob.id)).to eq(false)
    end
  end
end
