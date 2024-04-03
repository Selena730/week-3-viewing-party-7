require 'rails_helper'

RSpec.describe 'User Login with Location', type: :feature do
  let!(:user) { User.create(name: 'User One', email: 'email@example.com', password: 'password123') }

  it 'allows user to enter location on login' do
    visit '/login'

    fill_in :email, with: user.email
    fill_in :password, with: 'password123'
    fill_in :location, with: 'Denver, CO'
    click_button 'Log In'

    expect(page).to have_content('Denver, CO')

    visit '/login'
    expect(find_field('Location').value).to eq 'Denver, CO'
  end
end