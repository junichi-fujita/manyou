# == Schema Information
#
# Table name: labelings
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  label_id   :bigint
#  task_id    :bigint
#
# Indexes
#
#  index_labelings_on_label_id  (label_id)
#  index_labelings_on_task_id   (task_id)
#
# Foreign Keys
#
#  fk_rails_...  (label_id => labels.id)
#  fk_rails_...  (task_id => tasks.id)
#
FactoryBot.define do
  factory :labeling do
    task_id { Task.first.id }
    label_id { Label.first.id }
  end
  factory :another_labeling, class: Labeling do
    task_id { Task.second.id }
    label_id { Label.second.id}
  end
end
