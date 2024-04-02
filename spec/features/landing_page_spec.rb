require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    @user1 = User.create(name: 'Selena', email: 'selena@test.com', password: 'pass123word', password_confirmation: 'pass123word')
    @user2 = User.create(name: 'Gem', email: 'gem@test.com', password: '12345678', password_confirmation: '12345678')
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  it 'lists out existing users' do 
    
    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.email)
    end     
  end 
end
