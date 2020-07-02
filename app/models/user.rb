# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  name              :string           not null
#  self_introduction :text             default(""), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#
class User < ApplicationRecord
  MAX_LEN_SELF_INTRODUCTION = 300

  after_create :after_create

  validates :name, presence: true, uniqueness: true
  validates :self_introduction, length: { maximum: MAX_LEN_SELF_INTRODUCTION }

  rolify

  def after_create
    self.add_role(Role::REGULAR) if self.roles.blank?
  end
end
