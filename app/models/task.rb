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

    def search(query)
      st_val = { "未着手" => "yet", "着手済" => "started", "完了" => "done" }
      if query =~ /^未着手$|^着手済$|^完了$/
        query = st_val[query]
      end
      rel = order("id")
      if query.present?
        rel = rel.where(
          "name LIKE ? OR status = ?",
          "%#{query}%", "#{query}"
          )
      end
      rel
    end
  end
end
