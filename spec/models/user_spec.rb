require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'ユーザー管理' do
    before do
      @user = FactoryBot.build(:user)
    end

  context 'ユーザー登録ができる時' do
    it "nicknameと姓名、名前、姓名（フリガナ）、名前（フリガナ）、生年月日が存在すれば登録できる" do
      expect(@user).to be_valid
    end

    it "passwordが6文字以上であれば登録できる" do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      expect(@user).to be_valid
   end

  end

  context 'ユーザー登録ができない時' do
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
  it "surnameが空では登録できない" do
    @user.surname = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Surname can't be blank")
   end

   it "nameが空では登録できない" do
    @user.name = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Name can't be blank")
   end
   it "surnamefが空では登録できない" do
    @user.surnamef = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Surnamef can't be blank")
   end

   it "namefが空では登録できない" do 
    @user.namef = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Namef can't be blank")
   end

   it "birthdayが空では登録できない" do 
    @user.birthday = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Birthday can't be blank")
   end

  end
 end
end
