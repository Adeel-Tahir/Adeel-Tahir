class DeviseSessionsController < Devise::SessionsController
  after_action :after_user_login, only: :create
  def after_user_login
    show_cart_items_from_guest_to_user
    session[:cart] = current_cart
  end
end
