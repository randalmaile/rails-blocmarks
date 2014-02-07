# spec/features/visitor_signs_up_spec.rb
require 'spec_helper'

feature 'Visitor signs in' do
  background do
    @user = create(:user)
  end

  scenario 'with valid email and password' do
    visit log_in_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(page).to have_content('Logged in')
    expect(page).to have_content('My Bookmarks')
  end

  scenario "invalid email" do
    visit log_in_path
    fill_in 'Email', with: "invalid@example.com"
    click_button 'Log in'
    expect(page).to have_content 'Invalid email or password'
  end

  scenario "invalid password" do
    visit log_in_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: "bloc"
    click_button 'Log in'
    expect(page).to have_content 'Invalid email or password'
  end

end