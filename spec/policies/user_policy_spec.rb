require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  permissions :index?, :create? do
    it "grants access for public" do
      expect(subject).to permit(admin, User.new)
      expect(subject).to permit(user, User.new)
    end
  end

  permissions :show?, :update?, :destroy? do
    it "grants access for admin" do
      expect(subject).to permit(admin, User.new)
    end

    it "grants access if owns" do
      expect(subject).to permit(user, user)
    end
  end

  permissions ".scope" do
    it "allows all for admin" do
      expect(User).to receive(:all)
      subject::Scope.new(admin, User).resolve
    end

    it "allows oneself for regular" do
      expect(User).to receive(:where).with(id: user.id)
      subject::Scope.new(user, User).resolve
    end
  end
end
