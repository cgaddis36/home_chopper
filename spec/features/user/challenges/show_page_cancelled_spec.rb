require 'rails_helper'

describe 'User ' do
  before(:each) do
    @bob = User.create(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
    @chocolate = @bob.ingredients.create(name: "Chocolate")
    @squid = @bob.ingredients.create(name: "Squid")
    @blueberries = @bob.ingredients.create(name: "Blueberries")
    @game = @bob.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "dinner")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@bob)
  end

  it 'can play a game' do
    visit "/users/#{@bob.id}/challenges/#{@game.id}"

    expect(current_path).to eq("/users/#{@bob.id}/challenges/#{@game.id}")

    expect(@game.game_status).to eq("before")

    click_on "Let's Get Choppin'!"

    @game.reload

    expect(@game.game_status).to eq("playing")

    expect(current_path).to eq("/users/#{@bob.id}/challenges/#{@game.id}")

    click_on "Cancel Game"

    @game.reload

    expect(@game.game_status).to eq("cancelled")

    expect(current_path).to eq("/users/#{@bob.id}/challenges/#{@game.id}")

    expect(page).to have_content("This game has been cancelled.")
    expect(page).to have_content("Would you like to try again with a fresh basket?")
    expect(page).to have_button("Start New Game")
    expect(page).to have_content("Would you like to change your pantry ingredients?")
    expect(page).to have_button("Your Pantry")

    click_on 'Start New Game'

    expect(current_path).to eq("/users/#{@bob.id}/challenges/new")

    select('20', :from => :time_limit)
    select('Three Ingredients', :from => :basket_size)
    select('Dinner', :from => :meal_type)
    click_on "Start New Game"

    game = Challenge.last

    expect(game.game_status).to eq("before")
  end
end
