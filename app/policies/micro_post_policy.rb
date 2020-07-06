class MicroPostPolicy < ApplicationPolicy
  def owns?
    admin? || record.user == user
  end

  alias_method :index?, :public?
  alias_method :create?, :public?
  alias_method :show?, :public?

  alias_method :update?, :owns?
  alias_method :destroy?, :owns?

  class Scope < Scope
    def resolve
      if admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
