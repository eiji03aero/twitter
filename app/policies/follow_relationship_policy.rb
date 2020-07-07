class FollowRelationshipPolicy < ApplicationPolicy
  def owns?
    admin? || record.follower == user
  end

  alias_method :create?, :owns?
  alias_method :destroy?, :owns?

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
