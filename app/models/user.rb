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
  rolify

  after_create :after_create

  has_many :micro_posts, dependent: :destroy
  has_many :active_relationships, class_name: "FollowRelationship",
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :passive_relationships, class_name: "FollowRelationship",
    foreign_key: "followed_id",
    dependent: :destroy
  has_many :following, through: :active_relationships,
    source: :followed
  has_many :followers, through: :passive_relationships,
    source: :follower

  validates :name, presence: true, uniqueness: true
  validates :self_introduction, length: { maximum: MAX_LEN_SELF_INTRODUCTION }

  def after_create
    self.add_role(Role::REGULAR) if self.roles.blank?
  end

  def follow(user)
    following << user
  end

  def unfollow(user)
    active_relationships
      .find_by(followed_id: user.id)
      .destroy
  end

  def following?(user)
    following.include?(user)
  end
end
