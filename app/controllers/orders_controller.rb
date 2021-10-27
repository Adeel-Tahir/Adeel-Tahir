# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    # byebug
    if current_user
      if current_user.user?
        @orders = Order.where(user_id: current_user.id)
      elsif current_user.admin?
        @orders = Order.all
        @orders = @orders.filter_by_status(params[:status]) if params[:status].present?
      end
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(user_id: current_user&.id, status: 0, total: current_user.cart.total)
    @order.save
    @cart = Cart.find_by(user_id: current_user&.id)
    @cart_items = CartItem.where(cart_id: @cart.id)
    order = Order.find_by(id: params[:order])
    @cart_items.each do |items|
      i = CartItem.find_by(item_id: items.item_id)
      item = Item.find(i.item_id)
      @order.item_orders.create(order: order, quantity: items.quantity, item_id: items.item_id, price: item.price,
                                subtotal: i.sub_total)
    end
    destroy_cart_items
  end

  def update
    @order = Order.find_by(id: params[:id])
    if @order.update(order_params)
      flash[:notice] = 'Order Item updated'
      redirect_to orders_path
    else
      render :edit, flash[:alert] = 'Order Item not updated'
    end
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  private

  def destroy_cart_items
    @cart = Cart.find_by(user_id: current_user&.id)
    @cart_items = CartItem.where(cart_id: @cart.id)
    @cart_items.each(&:destroy)
    flash[:notice] = 'Thank you for Ordering,Order Confirmed'
    redirect_to resturants_path
  end

  def order_params
    params.require(:order).permit(:total, :status)
  end
end
