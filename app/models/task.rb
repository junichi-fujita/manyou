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
  end
end
