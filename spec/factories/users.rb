FactoryBot.define do
  factory :user do
    id { 1000 }
    name { "sample1" }
    email { "sample1@example.com" }
    password { "aaa" }
    password_confirmation { "aaa" }
    administrator { true }
  end

  factory :user2, class: User do
    id { 2000 }
    name { "sample2" }
    email { "sample2@example.com" }
    password { "aaa" }
    password_confirmation { "aaa" }
    administrator { false }
  end
end
