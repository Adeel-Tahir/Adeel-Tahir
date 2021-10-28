# frozen_string_literal: true

class ResturantPolicy < ApplicationPolicy
  def create?
    if user.nil?
      false
    else
      user.admin?
    end
  end

  alias edit? create?
  alias new? create?
  alias destroy? create?
  alias update? create?

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
