require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録が成功する場合' do
      it "全ての必須項目が満たされていれば登録できる" do
        expect(@user).to be_valid
      end

      it 'パスワードが6文字以上で、半角英数字が含まれていれば登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end

      it 'lastnameがあれば登録できる' do
        @user.lastname = '山田'
        expect(@user).to be_valid
      end

      it 'firstnameがあれば登録できる' do
        @user.firstname = '太郎'
        expect(@user).to be_valid
      end

      it 'firstnamekanaが全角カタカナであれば登録できる' do
        @user.firstnamekana = 'ヤマダ'
        expect(@user).to be_valid
      end

      it 'lastnamekanaが全角カタカナであれば登録できる' do
        @user.lastnamekana = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかない場合' do
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

      it 'メールアドレスは一意性が必要であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは@を含む必要があること' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは6文字以上でなければならないこと' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードが6文字以上であれば登録できること' do
        @user.password = '000000a'
        @user.password_confirmation = '000000a'
        expect(@user).to be_valid
      end

      it 'パスワードとパスワード確認が一致する必要があること' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'パスワードが数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
      end

      it 'パスワードが英字のみでは登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
      end

      it '全角文字のパスワードでは登録できないこと' do
        @user.password = '１２３４５６'
        @user.password_confirmation = '１２３４５６'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password must include both letters and numbers")
      end

      it 'firstnameが必須であること' do
        @user.firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname can't be blank")
      end

      it 'firstnameは全角でなければならないこと' do
        @user.firstname = 'tanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname 全角文字を使用してください")
      end

      it 'firstnamekanaは必須' do
        @user.firstnamekana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstnamekana can't be blank")
      end

      it 'lastnameが必須であること' do
        @user.lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname can't be blank")
      end

      it 'lastnameは全角でなければならないこと' do
        @user.lastname = 'akira'
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname 全角文字を使用してください")
      end

      it 'lastnamekanaは全角カタカナでなければならないこと' do
        @user.lastnamekana = 'akira'
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastnamekana 全角カタカナを使用してください")
      end

      it 'lastnamekanaが必須であること' do
        @user.lastnamekana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastnamekana can't be blank")
      end

      it 'lastnamekanaは全角カタカナでなければならないこと' do
        @user.lastnamekana = 'あきら'
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastnamekana 全角カタカナを使用してください")
      end

      it 'firstnamekanaは全角カタカナでなければならないこと' do
        @user.firstnamekana = 'たなか'
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstnamekana 全角カタカナを使用してください")
      end

      it 'birthdateが必須であること' do
        @user.birthdate = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdate can't be blank")
      end
    end
  end
end