# == Schema Information
#
# Table name: labels
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_labels_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Label, type: :model do
  it "ラベル名を空白にするとinvalid" do
    label1 = build(:label, name: nil)
    label1.valid?
    expect(label1.errors.messages[:name]).to include("を入力してください")
  end
  it "ラベル名が２０文字を超えるとinvalid" do
    label2 = build(:label, name: "a" * 21)
    label2.valid?
    expect(label2.errors.messages[:name]).to include("は20文字以内で入力してください")
  end
  it "ラベル名が１文字以上２０文字以下ならvalid" do
    label3 = build(:label, name: "a" * 20)
    expect(label3.valid?).to be_truthy
  end
end
