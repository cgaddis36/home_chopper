require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many :challenges }
    it { should have_many :ingredients }
    it { should have_many(:challenge_ingredients).through(:challenges) }
  end

  describe 'methods' do
    it "creates or updates itself from an oauth hash" do
      auth = { uid: "12345678910",
               info: { name: "Jack Black",
                       email: "jack@nothing.com" },
               credentials: { token: "abcdefg12345",
                              refresh_token: "12345abcdefg",
                              expires_at: DateTime.now } }
      User.update_or_create(auth)
      new_user = User.first

      expect(new_user.uid).to eq("12345678910")
      expect(new_user.email).to eq("jack@nothing.com")
      expect(new_user.name).to eq("Jack Black")
      expect(new_user.google_token).to eq("abcdefg12345")
    end
  end
end

#   describe 'roles' do
#     it 'can be created as default user' do
#       user = User.create(email: 'user@email.com', password: 'password', name: 'Jim', role: 0)

#       expect(user.role).to eq('default')
#       expect(user.default?).to be_truthy
#     end

#     it 'can be created as an Admin user' do
#       admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

#       expect(admin.role).to eq('admin')
#       expect(admin.admin?).to be_truthy
#     end
