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
FactoryBot.define do
  factory :user do
    name { Faker::Internet.unique.username }
    self_introduction { Faker::Quote.famous_last_words }
    password { Faker::Internet.password }

    factory :regular_user do
      before(:create) do |user|
        user.add_role(Role::REGULAR)
      end
    end

    factory :admin_user do
      before(:create) do |user|
        user.add_role(Role::ADMIN)
      end
    end
  end
end
