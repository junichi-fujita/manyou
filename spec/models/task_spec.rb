require 'rails_helper'

RSpec.describe Task, type: :model do

  example "名前を空白にしてはいけない。" do
    task = Task.new(name: nil, description: "aaa")
    task.valid?
    expect(task.errors.messages[:name]).to include("を入力してください") 
  end

  example "詳しい記述を空白にしてはいけない。" do
    task = Task.new(name: "aaa", description: nil)
    expect(task).to be_invalid
    expect(task.errors.messages[:description]).to include("を入力してください")
  end
  example "詳しい記述は２５５文字以下でなければならない。" do
    task = Task.new(name: "aaa", description: "a" * 256)
    expect(task).to_not be_valid
    expect(task.errors.messages[:description]).to include("は255文字以内で入力してください")
  end
  
  describe "検索のテスト" do

    before do
      @user = create(:user)
      @test1 = create(:task, user: @user)
      @test2 = create(:second_task, user: @user)
      @tasks = Task.all
    end

    example "名前検索欄でe1を検索するとname1が表示される" do
      name1 = Task.search_name("e1")
      expect(name1[0].name).to eq(@test1.name)
    end
  
    example "状態検索欄でdoneを検索するとname2が表示される" do
      name2 = Task.search_status("done")
      expect(name2[0].name).to eq(@test2.name)
    end
  
    example "名前検索欄でe1,状態検索欄でdoneを検索するとname1とname2が表示される" do
      name3 = Task.search_double("e1","done")
      expect(name3[0].name).to eq(@test1.name)
      expect(name3[1].name).to eq(@test2.name)
    end
  end
end
