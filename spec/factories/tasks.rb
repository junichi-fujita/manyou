FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "test_name#{n+1}" }
    sequence(:description) { |n| "test_description#{n+1}" }
  end
end
