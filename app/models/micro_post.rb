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
class MicroPost < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  MAX_LEN_CONTENT = 170

  belongs_to :user

  validates :content, length: { maximum: MAX_LEN_CONTENT }
end
