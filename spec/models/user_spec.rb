require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password }
  end 
  
  describe 'creates new user' do
    it 'creates a user with a password' do
      user = User.create(name: 'Selena', email: 'selena@test.com', password: 'pass123word', password_confirmation: 'pass123word')
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('pass123word')
    end
  end
end
