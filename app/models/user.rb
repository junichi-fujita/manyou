# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  administrator   :boolean          default(FALSE), not null
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy
  
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  after_save :only_administrator, on: :update
  before_destroy do
    throw :abort if User.where(administrator: true).count ==  1 && self.administrator?
  end

  def own?(task)
    self.id == task.user_id
  end

  private

  def only_administrator
    if User.where(administrator: true).count.zero?
      errors.add(:administrator, "のある者は最低１人必要です！")
      raise ActiveRecord::Rollback
    end
  end
end
