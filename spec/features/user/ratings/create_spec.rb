require 'rails_helper'

RSpec.describe "ratings" do
  before(:each) do
    @javier = User.create!(name: "Javier", email: "javier@sample.com", google_token: "1112131", role: 0)
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
    Rating.create(user_id: @bob.id, challenge_id: @jans_lunch.id, stars: 4)
    @jans_lunch = @janis.challenges.create!(time_limit: 20, basket_size: 5, meal_type: "lunch")
    ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @quail_eggs.id)
    ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @sprite.id)
    ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @peanut_butter.id)
    ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @avacado.id)
    ChallengeIngredient.create!(challenge_id: @jans_lunch.id, ingredient_id: @lemon.id)
    Rating.create(user_id: @bob.id, challenge_id: @jans_lunch.id, stars: 3)
    Rating.create(user_id: @javier.id, challenge_id: @jans_lunch.id, stars: 3)
    @bobs_dinner = @bob.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "dinner")
    ChallengeIngredient.create!(challenge_id: @bobs_dinner.id, ingredient_id: @squid.id)
    ChallengeIngredient.create!(challenge_id: @bobs_dinner.id, ingredient_id: @blueberries.id)
    ChallengeIngredient.create!(challenge_id: @bobs_dinner.id, ingredient_id: @toast.id)
    Rating.create(user_id: @janice.id, challenge_id: @bobs_dinner.id, stars: 4)
    Rating.create(user_id: @javier.id, challenge_id: @bobs_dinner.id, stars: 3)
    @javier_snack = @javier.challenges.create!(time_limit: 20, basket_size: 5, meal_type: "snack")
    ChallengeIngredient.create!(challenge_id: @javiers_snack.id, ingredient_id: @chocolate.id)
    ChallengeIngredient.create!(challenge_id: @javiers_snack.id, ingredient_id: @cinnamon.id)
    ChallengeIngredient.create!(challenge_id: @javiers_snack.id, ingredient_id: @eggs.id)
    ChallengeIngredient.create!(challenge_id: @javiers_snack.id, ingredient_id: @toast.id)
    ChallengeIngredient.create!(challenge_id: @javiers_snack.id, ingredient_id: @blueberries.id)
    Rating.create(user_id: @janice.id, challenge_id: @javier_snack.id, stars: 4)
    Rating.create(user_id: @bob.id, challenge_id: @javier_snack.id, stars: 3)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@javier)
  end

  it "can rate a challenge" do
    @javiers_snack.game_complete
    @javiers_snack.reload
    @bobs_dinner.game_complete
    @bobs_dinner.reload
    @jans_breakfast.game_complete
    @jans_breakfast.reload
    @jans_lunch.game_complete
    @jans_lunch.reload

    visit "/users/#{@javier.id}/dashboard"

    click_on "See All Challenges"

    expect(current_path).to eq("/challenges")

    expect(page).to have_content("Top 3 Rated Challenges")
    expect(page).to have_content("#{@janis.name}'s #{@jans_breakfast.id}")
    expect(page).to have_content("#{@bobs.name}'s #{@bobs_dinner.id}")
    expect(page).to have_content("#{@javier_snack.name}'s #{@javier_snack.id}")

    click_on
  end
end
