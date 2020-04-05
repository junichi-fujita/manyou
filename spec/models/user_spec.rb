require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Userモデルのvalidation" do
    it "nameを空白にするとinvalid" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors.messages[:name]).to include("を入力してください")
    end

    it "emailを空白にするとinvalid" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors.messages[:email]).to include("を入力してください")
    end

    it "emailの値が一意でなければinvalid" do
      user = create(:user, email: "aaa@aaa.com")
      user2 = build(:user2, email: "aaa@aaa.com")
      user2.valid?
      # binding.pry
      expect(user2.errors.messages[:email]).to include("はすでに存在します")
    end

    it "管理者が１人の場合、管理者でなくなるような変更はできない" do
      user = create(:user)
      expect(user.update(administrator: false)).to be_falsey
    end

    it "管理者が１人の場合、管理者を削除できない" do
      user = create(:user)
      expect(user.destroy).to be_falsey
    end
  end
end
