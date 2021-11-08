# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  delegate :admin?, to: :current_user

  delegate :user?, to: :current_user
end
