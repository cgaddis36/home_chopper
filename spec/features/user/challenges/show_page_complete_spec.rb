require 'rails_helper'

describe 'User ' do
  before(:each) do
    @bob = User.create!(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
    @chocolate = @bob.ingredients.create!(name: "Chocolate")
    @squid = @bob.ingredients.create!(name: "Squid")
    @crab = @bob.ingredients.create!(name: "Crab")
    @blueberries = @bob.ingredients.create!(name: "Blueberries")
    @cinnamon = @bob.ingredients.create!(name: "Cinnamon")
    @eggs = @bob.ingredients.create!(name: "Eggs")
    @toast = @bob.ingredients.create!(name: "Toast")
    @game = @bob.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "dinner")
    @contents = @game.ingredients
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@bob)
  end

  it 'can complete a game', :js do
    visit "/users/challenges/#{@game.id}"
    click_on "Let's Get Choppin'!"
    click_on "I Finished Early!"
    @game.reload

    expect(current_path).to eq("/users/challenges/#{@game.id}/edit")

    click_on "Don't Save a Photo"

    @game.reload

    expect(current_path).to eq("/users/challenges/#{@game.id}")
    expect(page).to have_content("Here Are Your Game Results!")
    expect(page).to have_content("Time: #{@game.time_limit} Minutes")
    expect(page).to have_content("Cooking: #{@game.meal_type.capitalize}")
    expect(page).to have_content("Basket Ingredients:")
    expect(page).to have_content("#{@contents[0].name}")
    expect(page).to have_content("#{@contents[1].name}")
    expect(page).to have_content("#{@contents[2].name}")
    expect(page).to have_button("Start New Game")
    expect(page).to have_button("Your Pantry")
  end
end
