class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 255 }
end
