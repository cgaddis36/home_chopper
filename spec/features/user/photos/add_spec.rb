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
    visit "/users/#{@jake.id}/dashboard"

    click_on("Start New Game")

    select('20', :from => :time_limit)
    select('Three Ingredients', :from => :basket_size)
    select('Dinner', :from => :meal_type)
    click_on("Start New Game")

    click_on("Let's Get Choppin'")

    click_on("I Finished Early!")

    challenge = @jake.challenges.first
    challenge.photos.new
    challenge.photos.first.image.attach(io: File.open('/Users/christophergaddis/turing/3module/projects/home_chopper/app/assets/images/foods/steak.jpeg'), filename: 'steak.jpeg')
    expect(challenge.photos.first.image.attached?).to be true

  end
end
