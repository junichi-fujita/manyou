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
