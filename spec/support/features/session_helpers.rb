# spec/support/features/session_helpers.rb
module Features
  module SessionHelpers
    def sign_up_with(name, email, password, password_confirmation)
      visit sign_up_path
      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password_confirmation
      click_button 'Create User'
    end
  end
end