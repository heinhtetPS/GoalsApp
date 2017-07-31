require 'rails_helper'

RSpec.describe User, type: :model do


it { should validate_presence_of(:username) }
it { should validate_presence_of(:password_digest) }
it { should validate_presence_of(:session_token) }
# it { should have_many(:goals) }
# it { should have_many(:views) }
it { should validate_length_of(:password).is_at_least(6) }

###methods
# self.find_by_credentials
# password=
# ensure_session_token
# reset_session_token!
# valid_password?

describe 'find by credentials' do
  it 'should find a user by credentials' do
    user = User.create(username: "Bob", password: "password")
    expect(User.find_by_credentials("Bob", "password")).to eq(user)
  end
end

describe 'session_token' do
  it 'assigns a session token if one is not given' do
    bob = User.create(username: "Bob", password: "password")
    expect(bob.session_token).not_to be_nil
  end

end

describe 'password=' do

  it 'does not store the password in the database' do
    user = User.create(username: "Bob", password: "password")
    expect(user.password).not_to be("password")
  end

  it 'creates a hashed password_digest using Bcrypt' do
    expect(BCrypt::Password).to receive(:create)
    User.create(username: "Bob", password: "password")
  end

end



end
