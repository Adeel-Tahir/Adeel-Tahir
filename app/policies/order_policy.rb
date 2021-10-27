# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  def index?
    if user.nil?
      false
    else
      true
    end
  end

  def create?
    if user.nil?
      false
    else
      true
    end
  end

  def edit?
    if user.nil?
      false
    else
      true
    end
  end

  def update?
    if user.nil?
      false
    else
      true
    end
  end

  def destroy?
    if user.nil?
      false
    else
      true
    end
  end

  def show?
    if user.nil?
      false
    else
      true
    end
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
