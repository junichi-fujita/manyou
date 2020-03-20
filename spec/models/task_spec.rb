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
end
