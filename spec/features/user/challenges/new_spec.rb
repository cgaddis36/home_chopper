require 'rails_helper'

describe 'User ' do
  before(:each) do
    @bob = User.create(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
    @chocolate = @bob.ingredients.create(name: "Chocolate")
    @squid = @bob.ingredients.create(name: "Squid")
    @blueberries = @bob.ingredients.create(name: "Blueberries")
    @cinnamon = @bob.ingredients.create(name: "Cinnamon")
    @eggs = @bob.ingredients.create(name: "Eggs")
    @toast = @bob.ingredients.create(name: "Toast")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@bob)
  end

  it 'can create a new game', :js do
    visit "/users/#{@bob.id}/dashboard"
    find("#starter").click

    expect(current_path).to eq("/users/challenges/new")

    select('20', from: :time_limit)
    select('Five Ingredients', from: :basket_size)
    select('Dinner', from: :meal_type)

    click_on "Start New Game"

    game = Challenge.last

    expect(game.game_status).to eq("playing")
  end
end
