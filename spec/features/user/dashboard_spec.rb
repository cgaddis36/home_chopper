require 'rails_helper'

RSpec.describe 'as a user' do
  describe 'on the dashboard' do
    it 'has a start button for game' do

      user = User.create(name: "Raymond")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit '/user/dashboard'

      expect(page).to have_button("Start Game")
    end  

    it "can not visit dashboard if not logged in" do
      visit '/user/dashboard'

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end