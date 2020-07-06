# == Schema Information
#
# Table name: roles
#
#  id            :bigint           not null, primary key
#  name          :string
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :bigint
#
# Indexes
#
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#  index_roles_on_resource_type_and_resource_id           (resource_type,resource_id)
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "validations" do
    subject { MicroPost.new }

    describe "content" do
      it "should not be too long" do
        subject.content = "a" * (MicroPost::MAX_LEN_CONTENT + 1)
        subject.validate
        expect(subject.errors.include?(:content)).to be true
      end
    end
  end
end
