# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  skip_before_action :verify_authenticity_token
  before_action :current_customer, :current_cart
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit
  include ApplicationHelper

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_customer
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def current_cart
    if user_signed_in?
      @shopping_cart = @user&.cart || Cart.create(user_id: current_user.id)
    elsif session[:cart]
      @shopping_cart = Cart.find(session[:cart])
    else
      @shopping_cart = Cart.create
      session[:cart] = @shopping_cart.id
    end
  end

  def login?
    !!current_customer
  end

  protected

  def guest_to_user
    return unless session[:cart]

    guest_cart = Cart.find(session[:cart])
    guest_cart.items.each do |item|
      CartItem.create(cart_id: current_cart.id, item_id: item.id, quantity: CartItem.find_by(item_id: item.id).quantity)
    end
    destroy_guest(guest_cart)
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  def destroy_guest(guest_cart)
    guest_cart.destroy
    session[:cart] = nil
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
  end
end
