require 'rails_helper'

RSpec.describe "User Registration" do
  xit 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_button 'Create New User'

    expect(page).to have_content("User One's Dashboard")
  end 

  xit 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com')

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    fill_in 'user_password', with: 'password'  
    fill_in 'user_password_confirmation', with: 'password'  
  
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  it 'displays errors when required fields are missing or passwords do not match' do
    visit register_path

    fill_in 'user_name', with: ''  
    fill_in 'user_email', with: '' 
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'different'  
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match Password")

  end
end
