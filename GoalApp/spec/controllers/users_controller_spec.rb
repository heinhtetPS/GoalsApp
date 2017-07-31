require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET#new" do
    it 'should render new user page' do
      get :new
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST#create" do
    it 'should reject an invalid password' do
      post :create, user: { username: "Bob", password: "123" }
      expect(response).to render_template("new")
      expect(flash[:errors]).to be_present
    end

    # it 'should reject a non-unique username' do
    #   User.create(username: "Bob", password: "password")
    #   get :new
    #   expect(response).to render_template("new")
    #   # debugger
    #   # expect(flash[:errors]).to be_present
    #   post :create, user: { username: "Bob", password: "password" }
    # end

    it 'on successful creation should redirect to index goals page' do
      post :create, user: { username: "Bob", password: "password" }
      expect(response).to redirect_to(goals_url)
    end

    it 'should log in user' do
      post :create, user: { username: "Bob", password: "password" }
      user = User.find_by_username("Bob")
      expect(session[:session_token]).to eq(user.session_token)
    end

  end

end
