require 'rails_helper'
require 'selenium-webdriver'

RSpec.describe "ラベル管理機能", type: :system do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user2) }
  let!(:task) { create(:task, user: user) }
  let!(:second_task) { create(:second_task, user: user2) }
  let!(:label) { create(:label, user: user) }
  let!(:another_label) { create(:another_label, user: user2) }
  let!(:labeling) { create(:labeling) }
  let!(:another_labeling) { create(:another_labeling) }
  

  def login
    visit new_user_path
    fill_in "t_email", with: "sample1@example.com"
    fill_in "t_password", with: "aaa"
    click_on "ログイン"
  end

  describe "ラベルの作成画面" do
    before do
      login
    end
    it "ラベル作成画面で、ラベルを入力するとタスクの新規画面にラベルが表示される" do
      visit new_label_path
      fill_in "label_name", with: "c++"
      click_on "登録する"
      expect(page).to have_content("c++")
    end
    it "タスク新規登録画面で、ラベルを削除するとラベルが消える" do
      visit new_task_path
      label1 = create(:label, name: "test1", user_id: user.id)
      click_on "削除"
      expect(page).to have_content("ラベルを削除しました。")
    end
    it "タスク一覧画面でラベルの絞り込みをpythonを選択するとname1が表示される" do
      visit root_path
      select "python", from: "label_id", match: :first
      expect(page).to have_content("name1")
    end
    it "タスク一覧画面でラベルの絞り込みをkotlinを選択するとname1は表示されない" do
      visit root_path
      select "kotlin", from: "label_id", match: :first
      expect(page).to_not have_content("name1")
    end
  end
end