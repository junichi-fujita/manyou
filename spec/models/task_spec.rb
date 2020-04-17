# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  end_date    :datetime
#  name        :string           not null
#  priority    :integer
#  status      :string           default("yet"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_tasks_on_status   (status)
#  index_tasks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
      result1 = Task.search_name("e1")
      expect(result1[0].name).to eq(@test1.name)
    end
  
    example "状態検索欄でdoneを検索するとname2が表示される" do
      result2 = Task.search_status("done")
      expect(result2[0].name).to eq(@test2.name)
    end
  
    example "名前検索欄でe1,状態検索欄でdoneを検索するとname1とname2が表示される" do
      result3 = Task.search_double("e1","done")
      expect(result3[0].name).to eq(@test1.name)
      expect(result3[1].name).to eq(@test2.name)
    end
  end
end
