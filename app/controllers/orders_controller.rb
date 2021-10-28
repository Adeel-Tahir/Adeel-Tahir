# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :check_permissions, only: %i[index new update create show]

  def index
    return unless current_user

    if current_user.user?
      @orders = Order.where(user_id: current_user.id)
    elsif current_user.admin?
      @orders = Order.all
      @orders = @orders.filter_by_status(params[:status]) if params[:status].present?
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(user_id: current_user&.id, status: 0, total: current_user.cart.total)
    @order.save
    shift_data_to_order
  end

  def update
    @order = Order.find_by(id: params[:id])
    if @order.update(order_params)
      redirect_to orders_path, notice: 'Order Item updated'
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
    @cart_items = @cart.cart_items
    @cart_items.each(&:destroy)
    redirect_to resturants_path, notice: 'Thank you for Ordering,Order Confirmed'
  end

  def order_params
    params.require(:order).permit(:total, :status)
  end

  def check_permissions
    authorize Order
  end

  def shift_data_to_order
    @cart = Cart.find_by(user_id: current_user&.id)
    @cart_items = @cart.cart_items
    order = Order.find_by(id: params[:order])
    create_order(order)
  end

  def create_order(order)
    @cart_items.each do |items|
      i = CartItem.find_by(item_id: items.item_id)
      item = Item.find(i.item_id)
      @order.item_orders.create(order: order, quantity: items.quantity, item_id: items.item_id, price: item.price,
                                subtotal: i.quantity * i.item.price)
    end
    destroy_cart_items
  end
end
