require 'rails_helper'
require 'selenium-webdriver'
# driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(:timeout => 100)

RSpec.describe "タスク管理機能", type: :system do
  # before do
  #   @task = Task.create!(name: "aaa", description: "bbb")
  # end

  before do
    @user = create(:user)
    @task = create(:task, user: @user)
    @second_task = create(:second_task, user: @user)
    visit new_user_path
    fill_in "t_email", with: "sample1@sample.com"
    fill_in "t_password", with: "aaa"
    click_on "ログイン"
  end
  #ok
  describe "タスク一覧画面" do
    context "タスクを作成した場合" do
      it "作成済のタスクが表示されること" do
        expect(page).to have_content "name1"
        expect(page).to have_content "name2"
        # expect(page).to have_content "ccc"
      end
    end
    #ok
    context "複数のタスクを作成した場合" do
      it "タスクが作成日時の降順に並んでいること" do
        # new_task = create(:task, name: "new_task", description: "new_description")
        # visit root_path
        task_list = all(".sort")
        # binding.pry
        expect(task_list[0]).to have_content "name2"
        expect(task_list[1]).to have_content "name1"
      end
    end
    context "終了期限の昇順ボタンを押した場合" do
      it "タスクが終了期限の昇順に並んでいること" do
        # visit root_path

        click_on "end_asc"
        sleep 0.5
        # wait.until(element.displayed?)
        sort_list = all(".sort")
        # wait.until{element.displayed?}
        expect(sort_list[0]).to have_content "name1"
        expect(sort_list[1]).to have_content "name2"
      end
    end
    context "終了期限の降順ボタンを押した場合" do
      it "タスクが終了期限の降順に並んでいること" do
        # visit root_path
        click_on "end_desc"
        sleep 0.5
        sort_list = all(".sort")
        expect(sort_list[0]).to have_content "name2"
        expect(sort_list[1]).to have_content "name1"
      end
    end

    context "優先順位の昇順ボタンを押した場合" do
      it "優先順位が優先度低い順に並んでいること" do
        # visit root_path
        click_on "pri_asc"
        sleep 0.5
        sort_list = all(".sort")
        expect(sort_list[0]).to have_content "name1"
        expect(sort_list[1]).to have_content "name2"
      end
    end

    context "優先順位の降順ボタンを押した場合" do
      it "優先順位が優先度高い順に並んでいること" do
        click_on "pri_desc"
        sleep 0.5
        sort_list = all(".sort")
        expect(sort_list[0]).to have_content "name2"
        expect(sort_list[1]).to have_content "name1"
      end
    end
  end
  describe "タスクの登録画面" do
    context "必要項目を入力して、createボタンを押した場合" do
      it "データが保存されていること" do
        visit new_task_path
        fill_in "task_name", with: "hello"
        fill_in "task_description", with: "world"
        click_button "登録する"
        visit root_path
        expect(page).to have_content "hello"
        # expect(page).to have_content "world"
      end
    end
  end
  describe "タスク詳細画面" do
    context "任意のタスク詳細画面に遷移した場合" do
      it "当該タスクの内容が表示されたページに遷移すること" do
        visit task_path(@task)
        expect(page).to have_content "name1"
        expect(page).to have_content "description1"
        # expect(page).to have_content "ccc"
      end
    end
  end
end