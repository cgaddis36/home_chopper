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
  # test is without a timer, so it defininitely needs to be revised after the timer is added
  it 'can finish a game' do
    visit "/users/#{@bob.id}/challenges/#{@game.id}"

    expect(current_path).to eq("/users/#{@bob.id}/challenges/#{@game.id}")

    expect(@game.game_status).to eq("before")

    click_on "Let's Get Choppin'!"

    @game.reload

    expect(@game.game_status).to eq("playing")

    expect(current_path).to eq("/users/#{@bob.id}/challenges/#{@game.id}")

    click_on "I Finished Early!"

    @game.reload

    expect(@game.game_status).to eq("done")

    expect(current_path).to eq("/users/#{@bob.id}/challenges/#{@game.id}")
    expect(page).to have_content("Congratulations!")
    expect(page).to have_content("You did it! Share photo of your creation below!")
    expect(page).to have_button("Save Photo")

    click_on "Don't Save a Photo"

    @game.reload

    expect(@game.game_status).to eq("complete")

    expect(current_path).to eq("/users/#{@bob.id}/challenges/#{@game.id}")
  end
end
