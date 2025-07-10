require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end


describe 'ユーザー新規登録' do


  context '新規登録できるとき（正常系）' do
      it 'すべての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

  context '新規登録できないとき（異常系）' do

    it 'nicknameが空では登録できない(ニックネームが必須であること)' do
      @user.nickname = ''  # nicknameの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    
    it 'emailが空では登録できない(メールアドレスが必須であること)' do
      @user.email = ''  # emailの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it '重複したemailが存在する場合は登録できない(メールアドレスは一意であること)' do
      FactoryBot.create(:user, email: 'test@example.com')  # 先に同じメールアドレスのユーザーを作成
      @user = FactoryBot.build(:user, email: 'test@example.com')  # 同じメールアドレスで新規ユーザーを作成
      @user.valid?
      expect(@user.errors.full_messages).to include 'Email has already been taken'
    end

    it 'emailは@を含まないと登録できない(メールアドレスは@を含む必要があること)' do
      @user.email = 'invalidemail'  # 不正なメールアドレスを設定
      @user.valid?
      expect(@user.errors.full_messages).to include 'Email is invalid'
    end

    it 'passwordが空では登録できない(パスワードが必須であること)' do
      @user.password = ''  # passwordの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it 'passwordが5文字以下では登録できない(パスワードは6文字以上であること)' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
    end

    it 'passwordが英字のみでは登録できない(パスワードは、半角英数字混合での入力が必須であること)' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password は半角英数字混合で入力してください'
    end

    it 'passwordが数字のみでは登録できない(パスワードは、半角英数字混合での入力が必須であること)' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password は半角英数字混合で入力してください'
    end

    it 'passwordが一致しないときは登録できない(パスワードとパスワード（確認）は、値の一致が必須であること。)' do
      @user.password = 'abc123'
      @user.password_confirmation = 'different'
      @user.valid?
      expect(@user.errors.full_messages).to include  "Password confirmation doesn't match Password"
    end
        
    it 'last_nameが空では登録できない(お名前(全角)は、名字が必須であること。)' do
      @user.last_name = ''  # last_nameの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end

    it 'first_nameが空では登録できない(お名前(全角)は、名前が必須であること。)' do
      @user.first_name = ''  # first_nameの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end

    it 'last_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない(お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。)' do
      @user.last_name = 'Smith'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name は全角（漢字・ひらがな・カタカナ）で入力してください'
    end

    it 'first_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない(お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。)' do
      @user.first_name = 'Taro'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name は全角（漢字・ひらがな・カタカナ）で入力してください'
    end

    it 'last_name_kanaが空では登録できない(お名前(カナ)は、名字が必須であること。)' do
      @user.last_name_kana = ''  # last_name_kanaの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name kana can't be blank"
    end

    it 'first_name_kanaが空では登録できない(お名前(カナ)は、名前が必須であること。)' do
      @user.first_name_kana = ''  # first_name_kanaの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include "First name kana can't be blank"
    end

    it 'last_name_kanaが全角（カタカナ）でないと登録できない(お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。)' do
      @user = FactoryBot.build(:user, last_name_kana: 'Smith')  # 半角英字
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name kana は全角カタカナで入力してください'
    end

    it 'first_name_kanaが全角（カタカナ）でないと登録できない(お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。)' do
      @user = FactoryBot.build(:user, first_name_kana: 'Taro')  # 半角英字
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name kana は全角カタカナで入力してください'
    end

    it 'birth_dateが空では登録できない(生年月日が必須であること。)' do
      @user.birth_date = ''  # birth_dateの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include "Birth date can't be blank"
    end

  end
  end
end




  