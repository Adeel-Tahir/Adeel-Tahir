# frozen_string_literal: true

class CartPolicy < ApplicationPolicy
  def create?
    if user.nil?
      true
    else
      !user.admin?
    end
  end

  alias new? create?
  alias edit? create?
  alias update? create?
  alias destroy? create?
  alias index? create?

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
