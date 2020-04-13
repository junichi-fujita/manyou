# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  end_date    :datetime
#  name        :string           not null
#  priority    :integer
#  status      :string           default("yet"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_tasks_on_status   (status)
#  index_tasks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :task do
    name { "name1" }
    description { "description1" }
    end_date { Time.current }
    status { "yet" }
    priority { :low }
  end
  factory :second_task, class: Task do
    name { "name2" }
    description { "description2" }
    end_date { Time.current + 1.days }
    status { "done" }
    priority { :high }
  end
end
