FactoryBot.define do
  factory :task do
    name { "test_name" }
    description { "test_description" }
  end
  factory :second_task, class: Task do
    name { "new_task" }
    description { "new_description" }
  end
end
