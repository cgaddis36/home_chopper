require 'rails_helper'

RSpec.describe "After I finish my challenge" do
  before(:each) do
    @jake = User.create!(name: "John", email: "theduke@example.com", google_token: "12345", role: 0)
    @grouper = @jake.ingredients.create!(name: "Grouper")
    @farro = @jake.ingredients.create!(name: "Farro")
    @oj = @jake.ingredients.create!(name: "Orange Juice")
    @garlic = @jake.ingredients.create!(name: "Garlic")
    @pepper = @jake.ingredients.create!(name: "Pepper")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@jake)
  end

  it "I can upload a picture of my meal " do
    visit dashboard_index_path

    find("#starter").click

    select('20', from: :time_limit)
    select('Three Ingredients', from: :basket_size)
    select('Dinner', from: :meal_type)
    click_on("Begin New Game")

    click_on("Let's Get Choppin'")

    challenge = @jake.challenges.first

    challenge.photos.new
    challenge.photos.first.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'foods', 'steak.jpeg')), filename: 'steak.jpeg')
    expect(challenge.photos.first.image.attached?).to be true
    challenge.update!(game_status: 'complete')

    visit "/users/challenges/#{challenge.id}"

    expect(page).to have_css('#photos')
  end
end
