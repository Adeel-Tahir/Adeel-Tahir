# frozen_string_literal: true

class CartPolicy < ApplicationPolicy
  def create?
    !user.admin?
  end

  def edit?
    !user.admin?
  end

  def update?
    !user.admin?
  end

  def destroy?
    !user.admin?
  end

  def index?
    !user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
