require 'rails_helper'

RSpec.describe 'User Log Out', type: :feature do
  let!(:user) { User.create(name: 'User One', email: 'email@example.com', password: 'password123') }

  it 'logs out a user and updates the navigation links' do
    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: 'password123'
    click_button 'Log In'

    # expect(page).to have_content('User Ones Dashboard') 

    expect(page).to have_link('Log Out')

    click_link 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to have_link('Log In')
    expect(page).to have_link('Create an Account')
    expect(page).not_to have_link('Log Out')
  end
end