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
  end

  it 'can visit a show page and see the game information' do
    @jans_breakfast.game_complete
    @jans_lunch.game_complete
    @jans_breakfast.reload
    @jans_lunch.reload
    expect(@jans_breakfast.game_status).to eq("complete")
    expect(@jans_lunch.game_status).to eq("complete")

    visit "/challenges/#{@jans_breakfast.id}"

    expect(current_path).to eq("/challenges/#{@jans_breakfast.id}")

    expect(page).to have_content("Basket Size: #{@jans_breakfast.basket_size}")
    expect(page).to have_content(@jans_breakfast.id)
    expect(page).to have_content(@jelly.name)
    expect(page).to have_content(@lemon.name)
    expect(page).to have_content(@avacado.name)
    expect(page).to have_content("#{@jans_breakfast.time_limit} minutes")

    visit "/challenges/#{@jans_lunch.id}"

    expect(current_path).to eq("/challenges/#{@jans_lunch.id}")

    expect(page).to have_content("Basket Size: #{@jans_lunch.basket_size}")
    expect(page).to have_content(@jans_lunch.id)
    expect(page).to have_content(@quail_eggs.name)
    expect(page).to have_content(@sprite.name)
    expect(page).to have_content(@lemon.name)
    expect(page).to have_content(@avacado.name)
    expect(page).to have_content(@peanut_butter.name)
    expect(page).to have_content("#{@jans_lunch.time_limit} minutes")
  end
end
