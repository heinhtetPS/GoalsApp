require 'rails_helper'

RSpec.describe User, type: :model do


it { should validate_presence_of(:username) }
it { should validate_presence_of(:password_digest) }
it { should validate_presence_of(:session_token) }
it { should have_many(:goals) }
it { should have_many(:views) }
it { should validate_length_of(:password).is_at_least(6) }

###methods
# self.find_by_credentials
# password=
# ensure_session_token
# reset_session_token!
# valid_password?

describe 'find by credentials' do
  let(:user) { User.create(username: "Bob", password: "password") }
  it 'should find a user by credentials' do
    expect
  end
end



end
