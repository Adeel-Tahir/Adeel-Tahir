# frozen_string_literal: true

class DeviseSessionsController < Devise::SessionsController
  # after_action :after_user_login, only: [:create]
  def after_user_login
    guest_to_user
    session[:cart] = current_cart
  end

  def create
    super
    after_user_login
  end
end
