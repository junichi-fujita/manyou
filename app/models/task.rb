class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 255 }

  STATUS_VALUES = %w(yet started done)
  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.task.status_#{status}")
    end

    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status]}
    end

    # scope :search_subject, ->(query) { where("name LIKE ?", "%#{query}%")}
    # scope :search_status, ->(query) { where("status = ?", "#{query}")}

    def search(query)
      q_arr = query.split(/[[:blank:]]+/)
      st_val = { "未着手" => "yet", "着手済" => "started", "完了" => "done" }

      st_arr = q_arr.select { |n| n =~ /^未着手$|^着手済$|^完了$/}.map { |n| st_val[n] }
      name_arr = q_arr.reject { |n| n =~ /^未着手$|^着手済$|^完了$/}
      rel = order("id")
      
      if query.present?
        rel = rel.where(
          status: st_arr
          ).or(rel.where(
            "name LIKE ?",
            name_arr.map{|n|"%#{n}%"}
          ))
      end
      rel
    end
  end
end
