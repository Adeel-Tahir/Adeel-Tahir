# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def create?
    if user.nil?
      false
    else
      user.admin?
    end
  end

  alias new? create?
  alias edit? create?
  alias update? create?
  alias destroy? create?
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
