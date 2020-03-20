require 'rails_helper'

RSpec.describe Task, type: :model do
  example "名前を空白にしてはいけない。" do
    task = Task.new(name: nil, description: "aaa")
    task.valid?
    expect(task.errors.messages[:name]).to include("can't be blank") 
  end

  example "詳しい記述を空白にしてはいけない。" do
    task = Task.new(name: "aaa", description: nil)
    task.valid?
    expect(task.errors.messages[:description]).to include("can't be blank")
  end

  example "詳しい記述は２５５文字以下でなければならない。" do
    task = Task.new(name: "aaa", description: "a" * 256)
    task.valid?
    expect(task.errors.messages[:description]).to include("is too long (maximum is 255 characters)")
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

end
