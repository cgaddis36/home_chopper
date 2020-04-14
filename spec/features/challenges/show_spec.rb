require 'rails_helper'

RSpec.describe 'User ' do
  before(:each) do
    @janis = User.create!(name: "Janice", email: "janice@sample.com", google_token: "678910", role: 0)
    @jelly = @janis.ingredients.create!(name: "Jelly")
    @avacado = @janis.ingredients.create!(name: "Avacado")
    @lemon = @janis.ingredients.create!(name: "Lemon")
    @jans_breakfast = @janis.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "breakfast")
    ChallengeIngredient.create!(challenge_id: @jans_breakfast.id, ingredient_id: @jelly.id)
    ChallengeIngredient.create!(challenge_id: @jans_breakfast.id, ingredient_id: @lemon.id)
    ChallengeIngredient.create!(challenge_id: @jans_breakfast.id, ingredient_id: @avacado.id)
  end

  it 'can visit a show page and see the game information' do
    @jans_breakfast.game_complete
    @jans_breakfast.reload
    expect(@jans_breakfast.game_status).to eq("complete")

    visit "/challenges/#{@jans_breakfast.id}"

    expect(current_path).to eq("/challenges")
    expect(page).to have_content("Solo Challenges")
    within "#3ingredients" do
      within "#challenge-#{@jans_breakfast.id}" do
        expect(page).to have_content("Basket Size: #{@jans_breakfast.basket_size}")
        expect(page).to have_button(@jans_breakfast.id)
        expect(page).to have_content(@jelly.name)
        expect(page).to have_content(@lemon.name)
        expect(page).to have_content(@avacado.name)
        expect(page).to have_content("#{@jans_breakfast.time_limit} minutes")
      end

      within "#challenge-#{@bobs_dinner.id}" do
        expect(page).to have_content("Basket Size: #{@bobs_dinner.basket_size}")
        expect(page).to have_button(@bobs_dinner.id)
        expect(page).to have_content(@squid.name)
        expect(page).to have_content(@blueberries.name)
        expect(page).to have_content(@toast.name)
        expect(page).to have_content("#{@bobs_dinner.time_limit} minutes")
      end
    end

    within "#5ingredients" do
      within "#challenge-#{@jans_lunch.id}" do
        expect(page).to have_content("Basket Size: #{@jans_lunch.basket_size}")
        expect(page).to have_button(@jans_lunch.id)
        expect(page).to have_content(@quail_eggs.name)
        expect(page).to have_content(@sprite.name)
        expect(page).to have_content(@lemon.name)
        expect(page).to have_content(@avacado.name)
        expect(page).to have_content(@peanut_butter.name)
        expect(page).to have_content("#{@jans_lunch.time_limit} minutes")
      end

      within "#challenge-#{@bobs_snack.id}" do
        expect(page).to have_content("Basket Size: #{@bobs_snack.basket_size}")
        expect(page).to have_button(@bobs_snack.id)
        expect(page).to have_content(@chocolate.name)
        expect(page).to have_content(@cinnamon.name)
        expect(page).to have_content(@eggs.name)
        expect(page).to have_content(@toast.name)
        expect(page).to have_content(@blueberries.name)
        expect(page).to have_content("#{@bobs_snack.time_limit} minutes")
      end
    end

    click_on "#{@bobs_snack.id}"

    expect(current_path).to eq("/challenges/#{@bobs_snack.id}")
  end
end
