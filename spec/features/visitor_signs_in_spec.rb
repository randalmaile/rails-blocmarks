# spec/features/visitor_signs_up_spec.rb
require 'spec_helper'

feature 'Visitor signs in' do
  background do
    @user = create(:user)
    @user2 = create(:user)
  end

  scenario 'with valid email and password' do
    visit log_in_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(page).to have_content('Logged in')
    expect(page).to have_content('My Bookmarks')
  end

  given(:other_user) { @user2 }

  scenario "Signing in as another user" do
    visit log_in_path
    fill_in 'Email', with: other_user.email
    fill_in 'Password', with: other_user.password
    click_button 'Log in'
    expect(page).to have_content ''
  end
end