FactoryBot.define do
  factory :task do
    name { "name1" }
    description { "description1" }
    end_date { Time.current}
    status { "yet" }
    priority { "low" }
  end
  factory :second_task, class: Task do
    name { "name2" }
    description { "description2" }
    end_date { Time.current + 1.days}
    status { "done"}
    priority {"high"}
  end
end
