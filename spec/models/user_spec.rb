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
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    subject { User.new }

    describe "name" do
      it "should be present" do
        subject.name = nil
        subject.validate
        expect(subject.errors.include?(:name)).to be true
      end
    end

    describe "self_introduction" do
      it "should not be too long" do
        subject.self_introduction = "a" * (User::MAX_LEN_SELF_INTRODUCTION + 1)
        subject.validate
        expect(subject.errors.include?(:self_introduction)).to be true
      end
    end
  end
end
