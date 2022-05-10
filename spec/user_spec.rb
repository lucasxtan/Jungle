require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a User if all of the validations are true' do
    @user = User.new(name: "Sam", email: "samjones@email.com", password: "pas", password_confirmation: "pas")
    @user.valid?
    expect(@user.errors).not_to include("can\'t be blank")
    end

    it 'does not create a User if their name is missing' do
    @user = User.new(email: "samjones@email.com", password: "password", password_confirmation: "password")
    @user.valid?
    expect(@user.errors[:name]).to include("can\'t be blank")
    end
  
    it 'does not create a User if their email is missing' do
    @user = User.new( name: "Sam", password: "password", password_confirmation: "password")
    @user.valid?
    expect(@user.errors[:email]).to include("can\'t be blank")
    end

    it 'does not create a User if their email is not unique' do
    @user1 = User.new(name: "Sam",  email: "sam@gmail.com", password: "password", password_confirmation: "password")
    @user1.save
    @user2 = User.new(name: "David",  email: "sam@gmail.com", password: "password", password_confirmation: "password")
    @user2.valid?
    expect(@user2.errors[:email]).to include("has already been taken")
    end
    it 'does not create a User if their passwords do not match' do
    @user = User.new(name: "Sam",  email: "sam@gmail.com", password: "password", password_confirmation: "ABCDEFG")
    @user.valid?
    expect(@user.errors[:password_confirmation]).to include("doesn\'t match Password")
    end
    it 'does not create a User if there is no password' do
    @user = User.new(name: "Sam",  email: "sam@gmail.com")
    @user.valid?
    expect(@user.errors[:password]).to include("can\'t be blank")
    end
    it 'does not create a User if there the password is too short' do
    @user = User.new(name: "Sam",  email: "sam@gmail.com", password: "pas", password_confirmation: "pas")
    @user.valid?
    expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should log the user in if everything is correct' do
      @user = User.new(name: "Sam",  email: "sammy123@gmail.com", password: "password", password_confirmation: "password")
      @user.save!
      expect(User.authenticate_with_credentials("sammy123@gmail.com", "password")).to be_present
    end
    it 'does not log the user in if the email is wrong' do
      @user = User.new(name: "Sam",  email: "abc123@gmail.com", password: "password", password_confirmation: "password")
      @user.save!
      expect(User.authenticate_with_credentials("sammy123@gmail.com", "password")).not_to be_present
    end
    it 'does not log the user in if the password is wrong' do
      @user = User.new(name: "Sam",  email: "sammy123@gmail.com", password: "password", password_confirmation: "password")
      @user.save!
      expect(User.authenticate_with_credentials("sammy123@gmail.com", "ABCDEFG")).not_to be_present
    end
    it 'logs the user in even if the email contains spaces' do
      @user = User.new(name: "Sam",  email: "sammy123@gmail.com", password: "password", password_confirmation: "password")
      @user.save!
      expect(User.authenticate_with_credentials("  sammy123@gmail.com   ", "password")).to be_present
    end
    it 'logs the user in even if the email is typed with a different case' do
      @user = User.new(name: "Sam",  email: "sammy123@gmail.com", password: "password", password_confirmation: "password")
      @user.save!
      expect(User.authenticate_with_credentials("  SAMMY123@gmail.com   ", "password")).to be_present
    end
  end
end