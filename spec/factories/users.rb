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
FactoryBot.define do
  factory :user do
    name { "sample1" }
    email { "sample1@example.com" }
    password { "aaa" }
    password_confirmation { "aaa" }
    administrator { true }
    end

  factory :user2, class: User do
    name { "sample2" }
    email { "sample2@example.com" }
    password { "aaa" }
    password_confirmation { "aaa" }
    administrator { false }
  end
end
