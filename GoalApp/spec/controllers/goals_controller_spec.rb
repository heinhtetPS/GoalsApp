require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let(:bob) { User.create!(username: "Bob", password: "password") }

  describe "GET#new" do
    it 'should render new goals page' do
      get :new
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end

    it 'redirects to the login page if not logged in' do
      allow(controller).to receive(:current_user) { nil }
      get :new, goal: {}
       expect(response).to redirect_to(new_session_url)
    end
  end

  describe "POST#create" do
    it 'should reject invalid params' do
      post :create, goal: {title: "", body: "", user_id: bob.id }
      expect(response).to render_template("new")
      expect(flash[:errors]).to be_present
    end

    it 'on successful creation, should redirect you to that goal page' do
      post :create, goal: {title: "hello", body: "Im Bob", user_id: bob.id }
      expect(response).to redirect_to(goal_url(Goal.last))
    end

  describe "GET#index" do

    it "should render the index page" do
      get :index
      expect(response).to render_template("index")
      expect(response).to have_http_status(200)
    end

    # it "only displays all public goals" do
    #
    # end
    #
    # it "should display your private goals" do
    #
    # end


  end


  describe "GET#show" do
    it "should render a goal show page" do
      get :show
      expect(response).to render_template("show")
      expect(response).to have_http_status(200)
    end

  end

  describe "DELETE#destroy"
    it "should remove the goal out of the database" do
      g = Goal.create(title: "hello", body: "Im Bob", user_id: bob.id)
      delete :destroy, id: g.id
      expect(Goal.all).to be_empty
    end
  end

  describe "PATCH#update" do
    it "should edit goal and update the database" do
      g = Goal.create(title: "hello", body: "Im Bob", user_id: bob.id)
      patch :update, id: g.id, goal: { title: "goodbye" }
      updated_goal = Goal.find(g.id)
      expect(updated_goal.title).to eq("goodbye")
    end

    it "should only let you update if logged in" do
      allow(controller).to receive(:current_user) { nil }
      g = Goal.create(title: "hello", body: "Im Bob", user_id: bob.id)
      patch :update, id: g.id, goal: { title: "goodbye" }
      updated_goal = Goal.find(g.id)
      expect(updated_goal.title).to eq("hello")
    end
  end

  describe "GET#edit" do
    it "renders edit page" do
      get :edit
      expect(response).to render_template("edit")
    end

    it "only renders edit page if logged in as goal owner" do
      allow(controller).to receive(:current_user) { nil }
      get :edit
      expect(response).to redirect_to new_session_url
    end
  end


end
