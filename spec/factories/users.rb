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
FactoryBot.define do
  factory :user do
    name { Faker::Internet.unique.username }
    self_introduction { Faker::Quote.famous_last_words }
  end
end
