# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :current_customer, :current_cart

  include Pundit
  include ApplicationHelper

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_customer
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def current_cart
    if user_signed_in?
      @shopping_cart = @user&.cart || Cart.create(user_id: current_user.id)
      # byebug
    elsif session[:cart]
      @shopping_cart =  Cart.find(session[:cart])
    else
      @shopping_cart = Cart.create
      session[:cart] = @shopping_cart.id
    end

  end

  def login?
    !!current_customer
  end

  def show_cart_items_from_guest_to_user

    if session[:cart]
      user_cart=current_cart
      guest_cart=Cart.find(session[:cart])
      guest_cart.items.each{|item| CartItem.create(cart_id: current_cart.id,item_id: item.id)}
      CartItem.where(cart_id: guest_cart.id).delete_all
      guest_cart.destroy
      session[:cart]=nil
    end

  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end
end
