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
require 'rails_helper'

RSpec.describe MicroPost, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
