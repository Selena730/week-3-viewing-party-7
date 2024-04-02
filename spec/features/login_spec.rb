require 'rails_helper'

RSpec.describe 'User Login', type: :feature do
  describe 'Logging in' do
    before do
        @user = User.create(name: 'User One', email: 'email@example.com', password: 'password123')
    end

    it 'logs in successfully with correct credentials' do
      visit '/login'
      fill_in 'Email', with: 'email@example.com'
      fill_in 'Password', with: 'password123'
      click_button 'Log In'

      expect(current_path).to eq("/users/#{@user.id}")
      expect(page).to have_content("User One's Dashboard")
    end

    it 'fails to log in with incorrect credentials' do
      visit '/login'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'wrongpassword'
      click_button 'Log In'

      expect(current_path).to eq('/login')
      expect(page).to have_content('Invalid email or password')
    end
  end
end