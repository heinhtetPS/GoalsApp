require 'spec_helper'
require 'rails_helper'

feature 'User authentication' do
  let!(:user) { User.create(username: "Bob", password: "password") }

  feature "the signup process" do
    before :each do
      visit new_user_path
    end

    scenario "has a new user page" do
      expect(page).to have_content "Sign Up"
    end

    feature "signing up a user" do

      scenario "shows username on the homepage after signup" do
        visit new_user_path
          fill_in "Username", with: 'Cindy'
          fill_in "Password", with: 'password'
          click_button 'Submit'
          expect(page).to have_content 'Cindy'
      end

    end

  end

  feature "logging in" do

    scenario "shows username on the homepage after login" do
      visit new_session_path
      fill_in "Username", with: 'Bob'
      fill_in "Password", with: 'password'
      click_button 'Submit'
      expect(page).to have_content 'Bob'
    end
  end

  feature "logging out" do
    before(:each) do
      visit new_session_path
      fill_in "Username", with: 'Bob'
      fill_in "Password", with: 'password'
      click_button 'Submit'
      click_button 'Sign out'
    end

    scenario "begins with a logged out state" do
      expect(page).to have_content 'Sign In'
    end

    scenario "doesn't show username on the homepage after logout" do
      expect(page).to_not have_content 'Bob'
    end

  end
end
