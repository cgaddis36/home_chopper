require 'rails_helper'

RSpec.describe 'User ' do
  before(:each) do
    @janis = User.create!(name: "Janice", email: "janice@sample.com", google_token: "678910", role: 0)
    @peanut_butter = @janis.ingredients.create!(name: "Peanut Butter")
    @jelly = @janis.ingredients.create!(name: "Jelly")
    @avacado = @janis.ingredients.create!(name: "Avacado")
    @lemon = @janis.ingredients.create!(name: "Lemon")
    @sprite = @janis.ingredients.create!(name: "Sprite")
    @quail_eggs = @janis.ingredients.create!(name: "Quail Eggs")
    @chocolate = @janis.ingredients.create!(name: "Chocolate")
    @squid = @janis.ingredients.create!(name: "Squid")
    @blueberries = @janis.ingredients.create!(name: "Blueberries")
    @cinnamon = @janis.ingredients.create!(name: "Cinnamon")
    @eggs = @janis.ingredients.create!(name: "Eggs")
    @toast = @janis.ingredients.create!(name: "Toast")
    @jans_breakfast = @janis.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "breakfast")
    ChallengeIngredient.create!(challenge_id: @jans_breakfast.id, ingredient_id: @jelly.id)
    ChallengeIngredient.create!(challenge_id: @jans_breakfast.id, ingredient_id: @lemon.id)
    ChallengeIngredient.create!(challenge_id: @jans_breakfast.id, ingredient_id: @avacado.id)
    @jans_lunch = @janis.challenges.create!(time_limit: 20, basket_size: 5, meal_type: "lunch")
    ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @quail_eggs.id)
    ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @sprite.id)
    ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @peanut_butter.id)
    ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @avacado.id)
    ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @lemon.id)
    @jans_dinner = @janis.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "dinner")
    ChallengeIngredient.create!(challenge_id: @jans_dinner.id, ingredient_id: @squid.id)
    ChallengeIngredient.create!(challenge_id: @jans_dinner.id, ingredient_id: @blueberries.id)
    ChallengeIngredient.create!(challenge_id: @jans_dinner.id, ingredient_id: @toast.id)
    @jans_snack = @janis.challenges.create!(time_limit: 20, basket_size: 5, meal_type: "snack")
    ChallengeIngredient.create!(challenge_id: @jans_snack.id, ingredient_id: @chocolate.id)
    ChallengeIngredient.create!(challenge_id: @jans_snack.id, ingredient_id: @cinnamon.id)
    ChallengeIngredient.create!(challenge_id: @jans_snack.id, ingredient_id: @eggs.id)
    ChallengeIngredient.create!(challenge_id: @jans_snack.id, ingredient_id: @toast.id)
    ChallengeIngredient.create!(challenge_id: @jans_snack.id, ingredient_id: @blueberries.id)
    @jans_second_breakfast = @janis.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "breakfast")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@janis)
  end

  it 'can see all the games that have been played' do
    @jans_snack.game_complete
    @jans_snack.reload
    @jans_dinner.game_complete
    @jans_dinner.reload
    @jans_breakfast.game_complete
    @jans_breakfast.reload
    @jans_lunch.game_complete
    @jans_lunch.reload

    expect(@jans_second_breakfast.game_status).to eq("before")
    expect(@jans_snack.game_status).to eq("complete")
    expect(@jans_dinner.game_status).to eq("complete")
    expect(@jans_breakfast.game_status).to eq("complete")
    expect(@jans_lunch.game_status).to eq("complete")

    visit "/users/#{@janis.id}/challenges"
    #
    # expect(page).to_not have_link(@jans_second_breakfast.id)
    #
    # expect(current_path).to eq("/users/#{@janis.id}/challenges")
    # expect(page).to have_content("My Solo Challenges")
    # within "#3ingredients" do
    #   within "#challenge-#{@jans_breakfast.id}" do
    #     expect(page).to have_content("Basket Size: #{@jans_breakfast.basket_size}")
    #     expect(page).to have_button(@jans_breakfast.id)
    #     expect(page).to have_content(@jelly.name)
    #     expect(page).to have_content(@lemon.name)
    #     expect(page).to have_content(@avacado.name)
    #     expect(page).to have_content("#{@jans_breakfast.time_limit} minutes")
    #   end
    #
    #   within "#challenge-#{@jans_dinner.id}" do
    #     expect(page).to have_content("Basket Size: #{@jans_dinner.basket_size}")
    #     expect(page).to have_button(@jans_dinner.id)
    #     expect(page).to have_content(@squid.name)
    #     expect(page).to have_content(@blueberries.name)
    #     expect(page).to have_content(@toast.name)
    #     expect(page).to have_content("#{@jans_dinner.time_limit} minutes")
    #   end
    # end
    #
    # within "#5ingredients" do
    #   within "#challenge-#{@jans_lunch.id}" do
    #     expect(page).to have_content("Basket Size: #{@jans_lunch.basket_size}")
    #     expect(page).to have_button(@jans_lunch.id)
    #     expect(page).to have_content(@quail_eggs.name)
    #     expect(page).to have_content(@sprite.name)
    #     expect(page).to have_content(@lemon.name)
    #     expect(page).to have_content(@avacado.name)
    #     expect(page).to have_content(@peanut_butter.name)
    #     expect(page).to have_content("#{@jans_lunch.time_limit} minutes")
    #   end
    #
    #   within "#challenge-#{@jans_snack.id}" do
    #     expect(page).to have_content("Basket Size: #{@jans_snack.basket_size}")
    #     expect(page).to have_button(@jans_snack.id)
    #     expect(page).to have_content(@chocolate.name)
    #     expect(page).to have_content(@cinnamon.name)
    #     expect(page).to have_content(@eggs.name)
    #     expect(page).to have_content(@toast.name)
    #     expect(page).to have_content(@blueberries.name)
    #     expect(page).to have_content("#{@jans_snack.time_limit} minutes")
    #   end
    # end
    #
    # click_on "#{@jans_snack.id}"
    #
    # expect(current_path).to eq("/challenges/#{@jans_snack.id}")
  end
end
