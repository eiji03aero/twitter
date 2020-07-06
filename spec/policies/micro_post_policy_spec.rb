require 'rails_helper'

RSpec.describe MicroPostPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  permissions ".scope" do
    it "allows all for admin" do
      expect(MicroPost).to receive(:all)
      subject::Scope.new(admin, MicroPost).resolve
    end

    it "allows owned ones" do
      expect(MicroPost).to receive(:where).with(user_id: user.id)
      subject::Scope.new(user, MicroPost).resolve
    end
  end

  permissions :index?, :create?, :show? do
    it "grants access for public" do
      expect(subject).to permit(admin, User.new)
      expect(subject).to permit(user, User.new)
    end
  end

  permissions :update?, :destroy? do
    it "grants access for admin" do
      post = create(:micro_post, user_id: admin.id)
      expect(subject).to permit(admin, post)
    end

    it "grants access if owns" do
      post = create(:micro_post, user_id: user.id)
      expect(subject).to permit(user, post)
    end
  end
end
