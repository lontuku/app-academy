require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_path
    expect(page).to have_button 'Sign up'
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      visit new_user_path
      email = Faker::Internet.email
      fill_in 'Email', with: email
      fill_in 'Password', with: Faker::Internet.password(min_length: 6)
      click_button 'Sign up'

      expect(page).to have_content email
    end
  end

  feature 'logging in' do
    scenario 'shows username on the home page after login'
  end

  feature 'logging out' do
    scenario 'begins with a logged out state'

    scenario 'doesn\'t show username on the homepage after logout'
  end
end
