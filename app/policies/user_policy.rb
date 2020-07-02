class UserPolicy < ApplicationPolicy
  def owns?
    admin? || user.id == record.id
  end

  alias_method :index?, :public?
  alias_method :create?, :public?

  alias_method :show?, :owns?
  alias_method :update?, :owns?
  alias_method :destroy?, :owns?

  class Scope < Scope
    def resolve
      if admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end
