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
class Task < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 255 }

  enum priority: {
    low: 0,
    middle: 1,
    high: 2
  }

  scope :search_subject, -> (name_arr) { where("name LIKE ?", name_arr.map{|n|"%#{n}%"})}

  STATUS_VALUES = %w("" yet started done)
  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.task.status_#{status}")
    end

    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status]}
    end

    def search_name(query)
      rel = order("id")
      if query.present?
        rel = rel.where("name LIKE ?", "%#{query}%")
      end
      rel
    end

    def search_status(query)
      rel = order("id")
      if query.present?
        rel = rel.where(status: query)
      end
      rel
    end
    
    def search_double(q_name, q_status)
      rel = order("id")
      if q_name.present? && q_status.present?
        rel = rel.where("name LIKE ?", "%#{q_name}%").or(rel.where(status: q_status))
      end
      rel
    end
  end
end
