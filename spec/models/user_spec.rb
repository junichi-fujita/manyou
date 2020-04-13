# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  administrator   :boolean          default(FALSE), not null
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Userモデルのvalidation" do
    let(:user) { create(:user) }
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
      another_user = build(:user2, email: "aaa@aaa.com")
      another_user.valid?
      expect(another_user.errors.messages[:email]).to include("はすでに存在します")
    end

    it "管理者が１人の場合、管理者でなくなるような変更はできない" do
      expect(user.update(administrator: false)).to be_falsey
    end

    it "管理者が１人の場合、管理者を削除できない" do
      expect(user.destroy).to be_falsey
    end
  end
end
