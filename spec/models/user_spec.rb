require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with matching password and password confirmation" do
      @user = User.new(name: "Taejin", email: "TEST@TEST.com", password: "123456789", password_confirmation: "123456789")
      expect(@user).to be_valid
    end

    it "is not valid with non-matching password and password confirmation" do
      @user = User.new(name: "Taejin", email: "TEST@TEST.com", password: "123456789", password_confirmation: "12345678910")
      expect(@user).to_not be_valid
    end

    it "is valid with unique emails" do
      @user1 = User.new(name: "Taejin", email: "TEST1@TEST.com", password: "123456789", password_confirmation: "123456789")
      @user2 = User.new(name: "Taejin", email: "test2@test.com", password: "123456789", password_confirmation: "123456789")
      expect(@user1).to be_valid
      expect(@user2).to be_valid
    end

    it "is not valid with repeated emails" do
      @user1 = User.new(name: "T", email: "TEST@TEST.com", password: "123456789", password_confirmation: "123456789")
      expect(@user1).to be_valid
      @user1.save!
      @user2 = User.new(name: "Taejin", email: "test@test.com", password: "123456789", password_confirmation: "123456789")
      expect(@user2).to_not be_valid
    end

    it "is not valid without email or name" do
      @user1 = User.new(email: "TEST1@TEST.com", password: "123456789", password_confirmation: "123456789")
      @user2 = User.new(name: "Taejin", password: "123456789", password_confirmation: "123456789")
      expect(@user1).to_not be_valid
      expect(@user2).to_not be_valid
    end

    it "is not valid with password shorter than minimum length" do
      @user = User.new(name: "Taejin", email: "TEST@TEST.com", password: "12345", password_confirmation: "12345")
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    it 'can login with registered email and password' do
      @user = User.create(name: "test", email: "toast@google.com", password:"tomato", password_confirmation:"tomato")
      expect(User.authenticate_with_credentials("toast@google.com", "tomato")).to eq(@user)
    end

    it 'can not login with incorrect email or password' do
      @user = User.create(name: "test", email: "toast@google.com", password:"tomato", password_confirmation:"tomato")
      expect(User.authenticate_with_credentials("toast@google.com", "testtest")).to be_nil
      expect(User.authenticate_with_credentials("testtest@google.com", "tomato")).to be_nil
    end

    it 'can login and trim the spaces of email' do
      @user = User.create(name: "test", email: "toast@google.com", password:"tomato", password_confirmation:"tomato")
      expect(User.authenticate_with_credentials("        toast@google.com        ", "tomato")).to eq(@user)
    end

    it 'can login case insensitive in email' do
      @user = User.create(name: "test", email: "toast@google.com", password:"tomato", password_confirmation:"tomato")
      expect(User.authenticate_with_credentials("ToAsT@gOoglE.com", "tomato")).to eq(@user)
    end

  end

end
