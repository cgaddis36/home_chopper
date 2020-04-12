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

    contents = @game.basket_contents
    expect(contents.count).to eq(3)

    expect(page).to have_content("You're making #{@game.meal_type}")
    expect(page).to have_content("Here are your mystery basket contents!")

    within "#ingredient-#{contents[0].id}" do
      expect(page).to have_content("#{contents[0].name}")
    end

    within "#ingredient-#{contents[1].id}" do
      expect(page).to have_content("#{contents[1].name}")
    end
    within "#ingredient-#{contents[2].id}" do
      expect(page).to have_content("#{contents[2].name}")
    end

    expect(page).to have_button("Pause Game")
    expect(page).to have_button("Cancel Game")
  end
end
