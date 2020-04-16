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
    @bob = User.create!(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
    @chocolate = @bob.ingredients.create!(name: "Chocolate")
    @squid = @bob.ingredients.create!(name: "Squid")
    @blueberries = @bob.ingredients.create!(name: "Blueberries")
    @cinnamon = @bob.ingredients.create!(name: "Cinnamon")
    @eggs = @bob.ingredients.create!(name: "Eggs")
    @toast = @bob.ingredients.create!(name: "Toast")
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
    @bobs_dinner = @bob.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "dinner")
    ChallengeIngredient.create!(challenge_id: @bobs_dinner.id, ingredient_id: @squid.id)
    ChallengeIngredient.create!(challenge_id: @bobs_dinner.id, ingredient_id: @blueberries.id)
    ChallengeIngredient.create!(challenge_id: @bobs_dinner.id, ingredient_id: @toast.id)
    @bobs_snack = @bob.challenges.create!(time_limit: 20, basket_size: 5, meal_type: "snack")
    ChallengeIngredient.create!(challenge_id: @bobs_snack.id, ingredient_id: @chocolate.id)
    ChallengeIngredient.create!(challenge_id: @bobs_snack.id, ingredient_id: @cinnamon.id)
    ChallengeIngredient.create!(challenge_id: @bobs_snack.id, ingredient_id: @eggs.id)
    ChallengeIngredient.create!(challenge_id: @bobs_snack.id, ingredient_id: @toast.id)
    ChallengeIngredient.create!(challenge_id: @bobs_snack.id, ingredient_id: @blueberries.id)
    @jans_second_breakfast = @janis.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "breakfast")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@bob)
  end

  it 'can see all the games that have been played' do
    @bobs_snack.game_complete
    @bobs_snack.reload
    @bobs_dinner.game_complete
    @bobs_dinner.reload
    @jans_breakfast.game_complete
    @jans_breakfast.reload
    @jans_lunch.game_complete
    @jans_lunch.reload

    expect(@jans_second_breakfast.game_status).to eq("playing")
    expect(@bobs_snack.game_status).to eq("complete")
    expect(@bobs_dinner.game_status).to eq("complete")
    expect(@jans_breakfast.game_status).to eq("complete")
    expect(@jans_lunch.game_status).to eq("complete")

    visit "/challenges"

    expect(page).to_not have_link(@jans_second_breakfast.id)

    expect(current_path).to eq("/challenges")
    expect(page).to have_content("Solo Challenges")

    within "#3ingredients" do
      within "#challenge-#{@jans_breakfast.id}" do
        expect(page).to have_content("#{@jans_breakfast.user.name}'s #{@jans_breakfast.meal_type} challenge.")
        expect(page).to have_button(@jans_breakfast.id)
      end

      within "#challenge-#{@bobs_dinner.id}" do
        expect(page).to have_content("#{@bobs_dinner.user.name}'s #{@bobs_dinner.meal_type} challenge.")
        expect(page).to have_button(@bobs_dinner.id)
      end
    end

    within "#5ingredients" do
      within "#challenge-#{@jans_lunch.id}" do
        expect(page).to have_content("#{@jans_lunch.user.name}'s #{@jans_lunch.meal_type} challenge.")
        expect(page).to have_button(@jans_lunch.id)
      end

      within "#challenge-#{@bobs_snack.id}" do
        expect(page).to have_content("#{@bobs_snack.user.name}'s #{@bobs_snack.meal_type} challenge.")
        expect(page).to have_button(@bobs_snack.id)
      end
    end

    click_on "#{@bobs_snack.id}"

    expect(current_path).to eq("/challenges/#{@bobs_snack.id}")
  end
end
