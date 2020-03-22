class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 255 }

  enum priority: {
    low: 0,
    middle: 1,
    high: 2
  }

  scope :search_subject, -> (name_arr) { where("name LIKE ?", name_arr.map{|n|"%#{n}%"})}

  STATUS_VALUES = %w(yet started done)
  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.task.status_#{status}")
    end

    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status]}
    end

    def search(query)
      query_arr = query.split(/[[:blank:]]+/)
      status_hash = { "未着手" => "yet", "着手済" => "started", "完了" => "done" }

      status_arr = query_arr.select { |n| n =~ /^未着手$|^着手済$|^完了$/}.map { |n| status_hash[n] }
      name_arr = query_arr.reject { |n| n =~ /^未着手$|^着手済$|^完了$/}
      rel = order("id")

      if query.present?
        rel = rel.where(
          status: status_arr
          ).or(rel.search_subject(name_arr))
      end
      rel
    end

    def search_status(query)
      rel = order("id")
      rel = rel.where("status = ?", query)
    end
  end
end
