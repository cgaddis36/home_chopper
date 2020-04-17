require 'rails_helper'

describe 'User ' do
  before(:each) do
    @bob = User.create!(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
    @chocolate = @bob.ingredients.create!(name: "Chocolate")
    @squid = @bob.ingredients.create!(name: "Squid")
    @blueberries = @bob.ingredients.create!(name: "Blueberries")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@bob)
  end
  # test is without a timer, so it defininitely needs to be revised after the timer is added
  it 'can finish a game' do
    visit dashboard_index_path

    expect(current_path).to eq("/users/dashboard")

    find("#starter").click

    select('20', from: :time_limit)
    select('Three Ingredients', from: :basket_size)
    select('Dinner', from: :meal_type)
    click_on("Start New Game")

    game = Challenge.last

    expect(game.game_status).to eq("playing")

    click_on "Let's Get Choppin'!"

    game.reload

    expect(game.game_status).to eq("playing")

    expect(current_path).to eq("/users/challenges/#{game.id}")

    game.update!(game_status: "complete")

    expect(game.game_status).to eq("complete")

    visit "/users/challenges/#{game.id}"

    expect(page).to have_content("Here Are Your Game Results!!")
    expect(page).to have_content("Time: 20 Minutes")
    expect(page).to have_content("Cooking: Dinner")
    expect(page).to have_content("Chocolate")
    expect(page).to have_content("Squid")
    expect(page).to have_content("Blueberries")
  end
end
