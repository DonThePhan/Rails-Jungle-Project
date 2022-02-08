require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations:' do

    it "should be valid when entry is correct" do
      @user = User.new({
        first_name: 'Donny',
        last_name: 'Phan',
        email: 'test@gmail.com',
        password: 'asdf',
        password_confirmation: 'asdf'
      })
      expect(@user).to be_valid
    end
    
    context 'missing fields:' do
      
      it "should not be valid if first_name is not supplied" do
        @user = User.new({
          last_name: 'Phan',
          email: 'test@gmail.com',
          password: 'asdf',
          password_confirmation: 'asdf'
        })
        expect(@user).to_not be_valid
      end
      
      it "should not be valid if last_name is not supplied" do
        @user = User.new({
          first_name: 'Donny',
          email: 'test@gmail.com',
          password: 'asdf',
          password_confirmation: 'asdf'
        })
        expect(@user).to_not be_valid
      end
      
      it "should not be valid if email is not supplied" do
        @user = User.new({
          first_name: 'Donny',
          last_name: 'Phan',
          password: 'asdf',
          password_confirmation: 'asdf'
        })
        expect(@user).to_not be_valid
      end
      
      it "should not be valid if password is not supplied" do
        @user = User.new({
          first_name: 'Donny',
          last_name: 'Phan',
          email: 'test@gmail.com',
          password_confirmation: 'asdf'
        })
        expect(@user).to_not be_valid
      end
      
      it "should not be valid if password_confirmation is not supplied" do
        @user = User.new({
          first_name: 'Donny',
          last_name: 'Phan',
          email: 'test@gmail.com',
          password: 'asdf'
        })
        expect(@user).to_not be_valid
      end
    end
    
    it "should not be valid if password & confirmation don't match" do
      @user = User.new({
        first_name: 'Donny',
        last_name: 'Phan',
        email: 'test@gmail.com',
        password: 'asdf',
        password_confirmation: 'qwer'
      })
      expect(@user).to_not be_valid
    end
    
    it "should not be valid if email already exists (case insensitive)" do
      # note the use of CREATE instead of NEW - seems to keep history
      user1 = User.create({
        first_name: 'user1',
        last_name: 'Phan',
        email: 'TEST@gmail.com',
        password: 'asdf',
            password_confirmation: 'asdf'
          })
          user2 = User.new({
            first_name: 'user2',
            last_name: 'Phan',
            email: 'test@gmail.com',
            password: 'asdf',
            password_confirmation: 'asdf'
          })
      expect(user2).to_not be_valid
      expect(user2.errors[:email]).to include("has already been taken")
    end
    
    context "password" do
      it "should not save if password length is 3 or less" do

        @password = 'asd'

        @user = User.new({
          first_name: 'Donny',
          last_name: 'Phan',
          email: 'test@gmail.com',
          password: @password,
          password_confirmation: 'asd'
        })
        expect(@user).to_not be_valid
      end

      it "should not save if password length is 4 or more" do

        @password = 'asdf'

        @user = User.new({
          first_name: 'Donny',
          last_name: 'Phan',
          email: 'test@gmail.com',
          password: @password,
          password_confirmation: 'asdf'
        })
        expect(@user).to be_valid
      end
    end
  end 

  describe '.authenticate_with_credentials' do
    it "should authenticate if password is correct" do
      email = 'test@gmail.com'
      password = 'asdf'
      User.create({
        first_name: 'Donny',
        last_name: 'Phan',
        email: email,
        password: password,
        password_confirmation: password
      })
      expect(User.authenticate_with_credentials(email, password)).to_not be_falsy  
    end

    it "should not authenticate if password is incorrect" do
      email = 'test@gmail.com'
      password = 'asdf'
      incorrect_password = 'wrongPassword!!!'
      User.create({
        first_name: 'Donny',
        last_name: 'Phan',
        email: email,
        password: password,
        password_confirmation: password
      })
      expect(User.authenticate_with_credentials(email, incorrect_password)).to be_falsy  
    end

    it "should still authenticate if there are spaces before or after supplied email" do
      email = 'test@gmail.com'
      untrimmed_email = '  test@gmail.com  '
      password = 'asdf'
  
      User.create({
        first_name: 'Donny',
        last_name: 'Phan',
        email: email,
        password: password,
        password_confirmation: password
      })
      expect(User.authenticate_with_credentials(untrimmed_email, password)).to_not be_falsy
    end
    
    it "should still authenticate if email cases don't match" do
      email = 'test@gmail.com'
      email_mis_cased = 'TEST@gmail.com'
      password = 'asdf'
  
      User.create({
        first_name: 'Donny',
        last_name: 'Phan',
        email: email,
        password: password,
        password_confirmation: password
      })
      expect(User.authenticate_with_credentials(email_mis_cased, password)).to_not be_falsy
    end
  end
end