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
require 'rails_helper'

RSpec.describe Labeling, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
