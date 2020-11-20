require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'ユーザー管理' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "nicknameと姓名、名前、姓名（フリガナ）、名前（フリガナ）、email、passwordとpassword_confirmation、生年月日が存在すれば登録できる" do
      expect(@user).to be_valid
    end

    it "nicknameが空では登録できない" do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "emailが空では登録できない" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "emailに「＠」が含まれないと登録できない" do
      @user.email = "kkkgmail.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "emailが一意性である" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end


    it "passwordが空では登録できない" do
       @user.password = nil
       @user.valid?
       expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "passwordが6文字以上であれば登録できる" do
       @user.password = "123456"
       @user.password_confirmation = "123456"
       expect(@user).to be_valid
    end

    it "passwordが5文字以下であれば登録できない" do
       @user.password = "12345"
       @user.password_confirmation = "12345"
       @user.valid?
       expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "passwordとpassword_confirmationが不一致では登録できない" do
       @user.password = "123456"
       @user.password_confirmation = "1234567"
       @user.valid?
       expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "surnameの値が存在すれば登録できる" do
       expect(@user).to be_valid
    end

    it "nameの値が存在すれば登録できる" do
       expect(@user).to be_valid
    end
    it "surnamefの値が存在すれば登録できる" do
       expect(@user).to be_valid
    end

    it "namefの値が存在すれば登録できる" do 
       expect(@user).to be_valid
    end

    it "birthdayの値が存在すれば登録できる" do 
       expect(@user).to be_valid
    end
  end
end
