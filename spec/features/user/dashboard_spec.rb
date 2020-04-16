require 'rails_helper'

RSpec.describe 'as a user' do
  describe 'on the dashboard' do
    it 'has a start button for game' do
      bob = User.create(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(bob)

      visit "/users/dashboard"

      expect(page).to have_button("Start New Game")
    end

    it "can not visit dashboard if not logged in" do
      visit "/"

      expect(page).to_not have_content("Dashboard")
    end

    it "can use a link to the ingredients index from the dashboard" do
      bob = User.create(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(bob)

      visit "/"

      click_on "Pantry"

      expect(current_path).to eq("/users/ingredients")
    end
  end
end
