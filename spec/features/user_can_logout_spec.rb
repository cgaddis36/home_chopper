require 'rails_helper'

RSpec.describe 'user can log out' do
  scenario 'user logs in useer google oauth2 and then logs out' do
    stub_omniauth
    visit '/'

    click_link 'Login with Google'

    expect(page).to have_content("Jack Black")
    expect(page).to have_link("Logout")
    click_link 'Logout'

    expect(page).to have_link('Login with Google')


  end
end

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      uid: "12345678910",
      info: {
        name: "Jack Black",
        email: "jack@nothing.com",
      },
      credentials: {
        token: "abcdefg12345",
        refresh_token: "12345abcdefg",
        expires_at: DateTime.now
      }
  })
end
