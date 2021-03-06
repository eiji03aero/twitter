# == Schema Information
#
# Table name: micro_posts
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_micro_posts_on_user_id  (user_id)
#
FactoryBot.define do
  factory :micro_post do
    content { Faker::Quote.famous_last_words }

    trait :invalid do
      content { Faker::Lorem.paragraph_by_chars(number: MicroPost::MAX_LEN_CONTENT + 1)}
    end
  end
end
