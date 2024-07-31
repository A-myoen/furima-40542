require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録が成功' do
    it "全て満たせば登録できる" do
      expect(@user).to be_valid
    end
    it 'パスワードが6文字以上半角英数字であれば登録できる' do
      @user.password = '123abc'
      @user.password_confirmation = '123abc'
      expect(@user).to be_valid
    end
    it 'lastnameあれば登録できる' do
      @user.lastname = '山田'
      expect(@user).to be_valid
    end
    it 'firstnameあれば登録できる' do
      @user.firstname = '陸太郎'
      expect(@user).to be_valid
    end
    it 'firstnamekanaが全角カタカナであれば登録できる' do
      @user.lastnamekana = 'ヤマダ'
      expect(@user).to be_valid
    end
    it 'lastnamekanaが全角カタカナであれば登録できる' do
      @user.firstnamekana = 'リクタロウ'
      expect(@user).to be_valid
    end
  end
  end

    context '新規登録がうまくかないとき' do
    it "nicknameが必須であること" do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールアドレスが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'パスワードは、6文字以上で登録可であること' do
      @user.password = '000000a'
      @user.password_confirmation = '000000a'
      expect(@user).to be_valid
    end
    it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'firstnameが必須' do
      @user.firstname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstname can't be blank")
    end
    it 'firstnamekanaが必須' do
      @user.firstnamekana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstnamekana can't be blank")
    end
    it 'lasttnameが必須' do
      @user.lastname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname can't be blank")
    end
    it 'lastnamekanaが必須' do
      @user.lastnamekana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastnamekana can't be blank")
    end
    it 'birthdateが必須' do
      @user.birthdate = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthdate can't be blank")
    end
    end
end
