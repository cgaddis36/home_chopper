require 'rails_helper'

RSpec.describe 'user logs in' do
  scenario 'user logs in useer google oauth2' do
    stub_omniauth
    visit '/'

    click_link 'Login with Google'

    expect(page).to have_content("Jack Black")
    expect(page).to have_link("Logout")
  end
end

def stub_omniauth
  OmniAuth.config.test_mode = true
  oa_hash = OmniAuth::AuthHash.new({ uid: "12345678910",
                                     info: { name: "Jack Black",
                                             email: "jack@nothing.com" },
                                     credentials: { token: "abcdefg12345",
                                                    refresh_token: "12345abcdefg",
                                                    expires_at: DateTime.now } })
  OmniAuth.config.mock_auth[:google_oauth2] = oa_hash
end
