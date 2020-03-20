require 'rails_helper'
RSpec.describe "タスク管理機能", type: :system do
  # before do
  #   @task = Task.create!(name: "aaa", description: "bbb")
  # end

  before do
    @task = create(:task)
  end

  describe "タスク一覧画面" do
    context "タスクを作成した場合" do
      it "作成済のタスクが表示されること" do
        visit root_path
        expect(page).to have_content "test_name"
        expect(page).to have_content "test_description"
        # expect(page).to have_content "ccc"

      end
    end
  end
  describe "タスクの登録画面" do
    context "必要項目を入力して、createボタンを押した場合" do
      it "データが保存されていること" do
        visit new_task_path
        fill_in "task_name", with: "hello"
        fill_in "task_description", with: "world"
        click_button "Create Task"
        visit root_path
        expect(page).to have_content "hello"
        expect(page).to have_content "world"
      end
    end
  end
  describe "タスク詳細画面" do
    context "任意のタスク詳細画面に遷移した場合" do
      it "当該タスクの内容が表示されたページに遷移すること" do
        visit task_path(@task)
        expect(page).to have_content "test_name"
        expect(page).to have_content "test_description"
        # expect(page).to have_content "ccc"
      end
    end
  end
end