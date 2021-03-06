require 'rails_helper'
require 'selenium-webdriver'
wait = Selenium::WebDriver::Wait.new(:timeout => 100)

RSpec.describe "タスク管理機能", type: :system do

  let(:user) { create(:user) }
  let(:user2) { create(:user2) }
  let!(:task_admin) { create(:task, user: user) }
  let!(:second_task_admin) { create(:second_task, user: user) }
  let!(:task) { create(:task, user: user2) }
  let!(:second_task) { create(:second_task, user: user2) }

  def login
    visit new_user_path
    fill_in "t_email", with: "sample2@example.com"
    fill_in "t_password", with: "aaa"
    click_on "ログイン"
  end

  def admin_login
    visit new_user_path
    fill_in "t_email", with: "sample1@example.com"
    fill_in "t_password", with: "aaa"
    click_on "ログイン"
  end
  
  describe "タスク一覧画面" do
    before do
      login
    end
    context "タスクを作成した場合" do
      it "作成済のタスクが表示されること" do
        expect(page).to have_content "name1"
        expect(page).to have_content "name2"
      end
    end
    context "複数のタスクを作成した場合" do
      it "タスクが作成日時の降順に並んでいること" do
        task_list = all(".sort")
        expect(task_list[0]).to have_content "name2"
        expect(task_list[1]).to have_content "name1"
      end
    end
    context "終了期限の昇順ボタンを押した場合" do
      it "タスクが終了期限の昇順に並んでいること" do
        click_on "end_asc"
        sleep 0.5
        sort_list = all(".sort")
        expect(sort_list[0]).to have_content "name1"
        expect(sort_list[2]).to have_content "name2"
      end
    end
    context "終了期限の降順ボタンを押した場合" do
      it "タスクが終了期限の降順に並んでいること" do
        click_on "end_desc"
        sleep 0.5
        sort_list = all(".sort")
        expect(sort_list[0]).to have_content "name2"
        expect(sort_list[2]).to have_content "name1"
      end
    end

    context "優先順位の昇順ボタンを押した場合" do
      it "優先順位が優先度低い順に並んでいること" do
        click_on "pri_asc"
        sleep 0.5
        sort_list = all(".sort")
        expect(sort_list[0]).to have_content "name1"
        expect(sort_list[2]).to have_content "name2"
      end
    end

    context "優先順位の降順ボタンを押した場合" do
      it "優先順位が優先度高い順に並んでいること" do
        click_on "pri_desc"
        sleep 0.5
        sort_list = all(".sort")
        expect(sort_list[0]).to have_content "name2"
        expect(sort_list[2]).to have_content "name1"
      end
    end
  end
  describe "タスクの登録画面" do
    context "必要項目を入力して、createボタンを押した場合" do
      it "データが保存されていること" do
        login
        visit new_task_path
        fill_in "task_name", with: "hello"
        fill_in "task_description", with: "world"
        click_button "登録する"
        visit root_path
        expect(page).to have_content "hello"
      end
    end
  end
  describe "タスク詳細画面" do
    context "任意のタスク詳細画面に遷移した場合" do
      it "当該タスクの内容が表示されたページに遷移すること" do
        login
        visit task_path(task)
        expect(page).to have_content "name1"
        expect(page).to have_content "description1"
      end
    end
  end

  describe "一般ユーザーまたは管理者での閲覧権限" do
    context "一般ユーザーでログインし、他人のタスクにアクセスした場合" do
      it "他人のタスクに遷移する" do
        login
        visit task_path(task_admin.id)
        expect(page).to have_content("タスクの詳細")
      end
    end
    context "管理者でログインし、他人のタスクにアクセスした場合" do
      it "他人のタスクに遷移する" do
        admin_login
        visit task_path(task.id)
        expect(page).to have_content("タスクの詳細")
      end
    end
  end
end