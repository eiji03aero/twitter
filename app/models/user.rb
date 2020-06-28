# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  name              :string           default(""), not null
#  self_introduction :text             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name)
#
class User < ApplicationRecord
  MAX_LEN_SELF_INTRODUCTION = 300

  validates :name, presence: true
  validates :self_introduction, length: { maximum: MAX_LEN_SELF_INTRODUCTION }
end
