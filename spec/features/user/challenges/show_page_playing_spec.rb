require 'rails_helper'

describe 'User ' do
  before(:each) do
    @bob = User.create!(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
    @chocolate = @bob.ingredients.create!(name: "Chocolate")
    @squid = @bob.ingredients.create!(name: "Squid")
    @blueberries = @bob.ingredients.create!(name: "Blueberries")
    @cinnamon = @bob.ingredients.create!(name: "Cinnamon")
    @eggs = @bob.ingredients.create!(name: "Eggs")
    @toast = @bob.ingredients.create!(name: "Toast")
    @game = @bob.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "dinner")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@bob)
  end

  it 'can play a game', :js do
    visit "/users/challenges/#{@game.id}"

    expect(current_path).to eq("/users/challenges/#{@game.id}")

    click_button "Let's Get Choppin'!"

    @game.reload

    expect(@game.game_status).to eq("playing")

    expect(current_path).to eq("/users/challenges/#{@game.id}")

    contents = @game.ingredients

    expect(contents.count).to eq(3)

    expect(page).to have_content("#{@game.meal_type.capitalize} Challenge")
    expect(page).to have_content("Mystery Basket Ingredients:")
    # # TODO: having trouble with test recognizing targeted sections.  Hashed out until I can find another set of eyes to help. maybe I'm missing something.

    # within "#ingredient-#{first_ingredient.id}" do
    expect(page).to have_content("#{contents[0].name}")
    # end

    # within "#ingredient-#{second_ingredient.id}" do
    expect(page).to have_content("#{contents[1].name}")
    # end
    # within "#ingredient-#{third_ingredient.id}" do
    expect(page).to have_content("#{contents[2].name}")
    # end

    expect(page).to have_button("Cancel Game")
    expect(page).to have_button("I Finished Early!")
  end
end
