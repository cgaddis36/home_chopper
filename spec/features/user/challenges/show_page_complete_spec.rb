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
    @contents = @game.ingredients
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@bob)
  end
  # test is without a timer, so it defininitely needs to be revised after the timer is added
  it 'can complete a game' do
    visit "/users/#{@bob.id}/challenges/#{@game.id}"
    click_on "Let's Get Choppin'!"
    click_on "I Finished Early!"

    @game.reload

    expect(@game.game_status).to eq("done")

    click_on "Don't Save a Photo"

    @game.reload

    expect(@game.game_status).to eq("complete")

    expect(current_path).to eq("/users/#{@bob.id}/challenges/#{@game.id}")
    expect(page).to have_content("Here Are Your Game Results!")
    expect(page).to have_content("You had a #{@game.time_limit} minute challenge.")
    expect(page).to have_content("You were challenged to make a #{@game.meal_type}")
    expect(page).to have_content("Your Mystery Basket Ingredients Were:")
    expect(page).to have_content("#{@contents[0].name}")
    expect(page).to have_content("#{@contents[1].name}")
    expect(page).to have_content("#{@contents[2].name}")
    expect(page).to have_content("Would you like play again with a fresh basket?")
    expect(page).to have_button("Start New Game")
    expect(page).to have_content("Would you like to change your pantry ingredients?")
    expect(page).to have_button("Your Pantry")
    expect(page).to have_button("Your Dashboard")
  end
end
