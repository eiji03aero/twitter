# == Schema Information
#
# Table name: follow_relationships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer
#  follower_id :integer
#
# Indexes
#
#  index_follow_relationships_on_followed_id                  (followed_id)
#  index_follow_relationships_on_follower_id                  (follower_id)
#  index_follow_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
FactoryBot.define do
  factory :follow_relationship do
  end
end
