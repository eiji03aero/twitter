# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  name              :string           not null
#  password_digest   :string
#  self_introduction :text             default(""), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :self_introduction
end
