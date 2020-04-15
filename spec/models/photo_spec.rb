require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'relationships' do
    it { should belong_to :challenge }
  end
end
