FactoryBot.define do
  factory :task do
    name { "name1" }
    description { "description1" }
    end_date { Time.current}
    priority { "low" }
  end
  factory :second_task, class: Task do
    name { "name2" }
    description { "description2" }
    end_date { Time.current + 1.days}
    priority {"high"}
  end
end
