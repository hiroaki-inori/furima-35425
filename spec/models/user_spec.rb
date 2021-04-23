require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全て入力すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録/ユーザー情報が登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに@が存在しない場合登録できない' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが6文字以下では登録できない' do
        @user.password = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordに全角が入っている場合は登録できない' do
        @user.password = 'a１2345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordが半角数字のみの場合は登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordが半角英語のみの場合は登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが一致しない場合は登録できない' do
        @user.password_confirmation = "#{@user.password}aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
    context '新規登録/本人情報確認ができないとき' do
      it 'ユーザー本名は、名字と名前が空では登録できない' do
        @user.last_name = ''
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'ユーザー本名は、名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'ユーザー本名は、名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ)でなければ登録できない' do
        @user.last_name = 'yamada'
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it 'ユーザー本名のフリガナは、名字と名前が空では登録できない' do
        @user.last_name_kana = ''
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'ユーザー本名のフリガナは、名字が空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'ユーザー本名のフリガナは、名前が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'ユーザー本名のフリガナは、全角（カタカナ）でなければ登録できない' do
        @user.last_name_kana = 'ﾔﾏﾀﾞ'
        @user.first_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it 'ユーザーの生年月日が全て正しく選択されていないと登録できない' do
        @user.birthday = '--------'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'ユーザーの生年月日の「年」が選択されていないと登録できない' do
        @user.birthday = '---01-01'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'ユーザーの生年月日の「月」が選択されていないと登録できない' do
        @user.birthday = '1930----01'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'ユーザーの生年月日の「日」が選択されていないと登録できない' do
        @user.birthday = '1930-01---'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'ユーザーの生年月日の「年」と「月」が選択されていないと登録できない' do
        @user.birthday = '------01'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'ユーザーの生年月日の「年」と「日」が選択されていないと登録できない' do
        @user.birthday = '---01---'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'ユーザーの生年月日の「月」と「日」が選択されていないと登録できない' do
        @user.birthday = '1930------'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end

RSpec.describe User, type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'トップページ' do
    it 'ログアウト状態では、ヘッダーに新規登録/ログインボタンが表示される' do
      # トップページに移動する
      visit root_path
      # ヘッダーに新規登録/ログインボタンが表示されることを確認する
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
    end
    it 'ログイン状態では、ヘッダーにユーザーのニックネーム/ログアウトボタンが表示されること' do
      # ログインページに移動する
      visit new_user_session_path
      # メールアドレスとパスワードを入力
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ヘッダーにニックネーム/ログアウトボタンが表示されているのを確認する
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
    end
    it 'ヘッダーの新規登録ボタンをクリックすることで、新規登録ページに遷移できること' do
      # トップページに移動する
      visit root_path
      # ヘッダーに新規登録ボタンが表示される
      expect(page).to have_content('新規登録')
      # 新規登録リンクをクリック
      click_link '新規登録'
      # 新規登録ページへ変遷したことを確認する
      expect(current_path).to eq(new_user_registration_path)
    end
    it 'ヘッダーのログインボタンをクリックすることで、ログインページに遷移できること' do
      # トップページに移動する
      visit root_path
      # ヘッダーにログインボタンが表示される
      expect(page).to have_content('ログイン')
      # 新規登録リンクをクリック
      click_link 'ログイン'
      # 新規登録ページへ変遷したことを確認する
      expect(current_path).to eq(new_user_session_path)
    end
    it 'ヘッダーのログアウトボタンをクリックすることで、ログアウトができること' do
      # ログインページに移動する
      visit new_user_session_path
      # メールアドレスとパスワードを入力
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ヘッダーにログアウトボタンが表示されているのを確認する
      expect(page).to have_content('ログアウト')
      # ログアウトリンクをクリック
      click_link 'ログアウト'
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ヘッダーに新規登録/ログインボタンが表示されることを確認する
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
    end
  end
end
