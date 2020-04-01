require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do

  def login
    visit new_user_path
    fill_in "t_email", with: "sample2@sample.com"
    fill_in "t_password", with: "aaa"
    click_on "ログイン"
  end

  def admin_login
    visit new_user_path
    fill_in "t_email", with: "sample1@sample.com"
    fill_in "t_password", with: "aaa"
    click_on "ログイン"
  end

  before do
    @user1 = create(:user)
    @user2 = create(:user2)
  end

  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user_name', with: 'test'
        fill_in 'user_email', with: 'test@example.com'
        fill_in 'user_password', with: 'aaa'
        fill_in 'user_password_confirmation', with: 'aaa'
        click_on '登録する'
        # binding.pry
        # expect(current_path).to eq user_path(id: 1)
        expect(page).to have_content "「test」を登録しました。"
        # binding.pry
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit root_path
        expect(current_path).to eq new_user_path
      end
    end
  end

  describe 'セッション機能テスト' do
    context 'ユーザーのデータがあり、ログインしていない状態で' do
      it 'ログインのテスト' do
        login
        # binding.pry
        expect(current_path).to eq root_path
      end
    end
    context 'ログインした状態で' do
      before do
        login
      end
      it '自分の詳細画面に飛べること' do
        click_link "sample2"
        expect(page).to have_content "ユーザー詳細"
      end
      it '他人の詳細画面にとぶとタスク一覧ページに遷移する' do
        visit user_path(1)
        expect(page).to have_content "タスク一覧"
      end
      it 'ログアウトできること' do
        visit root_path
        click_link "ログアウト"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "ユーザー登録"
      end
      it '一般ユーザーは管理画面にアクセスできないこと' do
        visit admin_root_path
        expect(page).to have_content "タスク一覧"
      end
    end
  end
  describe '管理画面のテスト' do
    context '管理者でログインした状態で' do
      before do
        admin_login
      end
      it '管理者が管理画面にアクセスできること' do
        visit root_path
        click_on "管理者画面"
        expect(page).to have_content "管理者のトップページ"
      end
      it '管理者はユーザーを新規登録できること' do
        visit admin_root_path
        click_on "admin_new_user"
        fill_in 'user_name', with: 'test'
        fill_in 'user_email', with: 'test@example.com'
        fill_in 'user_password', with: 'aaa'
        fill_in 'user_password_confirmation', with: 'aaa'
        click_on '登録する'
        expect(page).to have_content "「test」を登録しました。"
      end
      it '管理者はユーザーの詳細画面にアクセスできる' do
        visit admin_root_path
        # binding.pry
        click_link "sample2"
        expect(page).to have_content "ユーザー詳細"
      end
      it '管理者はユーザーの編集画面からユーザーを編集できる' do
        visit admin_root_path
        all('#admin_edit')[-1].click
        fill_in "ユーザー名", with: "edit"
        click_on "更新する"
        expect(page).to have_content "「edit」を変更しました。"
      end
      it '管理者はユーザーを削除できる' do
        visit admin_root_path
        all('#admin_delete')[-1].click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "「sample2」を削除しました。"
      end
    end
  end
end
