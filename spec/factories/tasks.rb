FactoryBot.define do
  factory :task do
    name { "name1" }
    description { "description1" }
    end_date { Time.current}
    status { "yet" }
    priority { "low" }
    user_id { 1 }
  end
  factory :second_task, class: Task do
    name { "name2" }
    description { "description2" }
    end_date { Time.current + 1.days}
    status { "done"}
    priority {"high"}
    user_id { 2 }
  end
end
