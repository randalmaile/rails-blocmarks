# spec/features/visitor_signs_up_spec.rb
require 'spec_helper'
include Features::SessionHelpers

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'Jimbo jim', 'jjim@aol.com', 'sassafras', 'sassafras'
    expect(page).to have_content('Signed up! Start adding Blocmarks!')
  end

  scenario 'with blank password' do
    sign_up_with 'Jimbo jim', 'jjim@aol.com', '', ''
    expect(page).to have_content('Password can\'t be blank')
  end

  scenario 'without password confirmation' do
    sign_up_with 'Jimbo jim', 'jjim@aol.com', 'sassafras', ''
    expect(page).to have_content('Password doesn\'t match confirmation')
  end

  scenario 'with blank password' do
    sign_up_with 'Jimbo jim', '', 'sassafras', 'sassafras'
    expect(page).to have_content('Email can\'t be blank')
  end

end