# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy

  def create?
    if user.nil?
      false
    else
      true
    end
  end

  alias edit? create?
  alias update? create?
  alias destroy? create?
  alias index? create?
  alias show? create?
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
