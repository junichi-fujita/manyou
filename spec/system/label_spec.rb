require 'rails_helper'
require 'selenium-webdriver'

RSpec.describe "ラベル管理機能", type: :system do
  let!(:user) { create(:user) }
  let!(:label) { create(:label, user: user) }
  let(:another_label) { create(:another_label, user: user) }
  let!(:labels) { create_list(:label, 6) }

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
  end
end