# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
    # def index?
    #   current_user.admin?
    # end
    # def create?
    #   current_user.admin?
    # end
    # def update?
    #   true
    #   # current_user.admin?
    # end
    # def destroy?
    #   current_user.admin?
    # end
  end
end
