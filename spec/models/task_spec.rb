require 'rails_helper'

RSpec.describe Task, type: :model do
  example "名前を空白にしてはいけない。" do
    task = Task.new(name: nil, description: "aaa")
    task.valid?
    expect(task.errors.messages[:name]).to include("を入力してください") 
  end

  example "詳しい記述を空白にしてはいけない。" do
    task = Task.new(name: "aaa", description: nil)
    task.valid?
    expect(task.errors.messages[:description]).to include("を入力してください")
  end

  example "詳しい記述は２５５文字以下でなければならない。" do
    task = Task.new(name: "aaa", description: "a" * 256)
    task.valid?
    expect(task.errors.messages[:description]).to include("は255文字以内で入力してください")
  end

  before do
    @task = build(:task)
  end

  example "nameとdescriptionの両方が記述されていればok" do
    expect(@task.valid?).to eq(true)
  end

  example "nameが空だとNG" do
    @task.name = ""
    expect(@task.valid?).to eq(false)
  end

  example "descriptionが空だとNG" do
    @task.description = ""
    expect(@task.valid?).to eq(false)
  end

  example "descriptionが２５６文字以上ならNG" do
    @task.description = "a" * 256
    expect(@task.valid?).to eq(false)
  end

  before do
    @test1 = create(:task)
    @test2 = create(:second_task)
    @tasks = Task.all
  end

  example "e1を検索するとname1が表示される" do
    name1 = Task.search("e1")
    expect(name1[0].name).to eq(@test1.name)
  end

  example "doneを検索するとname2が表示される" do
    name2 = Task.search_status("done")
    expect(name2[0].name).to eq(@test2.name)
  end

end
