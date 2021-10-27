# frozen_string_literal: true

class CartPolicy < ApplicationPolicy
  def new
    if user.nil?
      true
    else
      !user.admin?
    end
  end

  def create?
    if user.nil?
      true
    else
      !user.admin?
    end
  end

  def edit?
    if user.nil?
      true
    else
      !user.admin?
    end
  end

  def update?
    if user.nil?
      true
    else
      !user.admin?
    end
  end

  def destroy?
    if user.nil?
      true
    else
      !user.admin?
    end
  end

  def index?
    if user.nil?
      true
    else
      !user.admin?
    end
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
