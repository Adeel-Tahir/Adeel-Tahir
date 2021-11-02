# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :check_authentication, only: %i[index new update create show]

  def index
    return unless current_user

    if current_user.user?
      @orders = current_user.orders
    elsif current_user.admin?
      @orders = Order.all
      @orders = @orders.filter_by_status(params[:status]) if params[:status].present?
    end
  end

  def new
    @order = Order.new
  end

  def create
    @cart=current_user.cart
    @cart_items=@cart.items
    @order = Order.new(user_id: current_user&.id, status: 0, total: @cart.total)
    if @order.save
      create_order
      redirect_to orders_path, notice: 'Thank you for Ordering,Order Confirmed'
    else
      redirect_to resturants_path, alert: 'Order not created'
    end
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
    redirect_to orders_path, alert: 'Order not Found' if @order.nil?
  end

  private
  def order_params
    params.require(:order).permit(:total, :status)
  end

  def check_authentication
    authenticate_user!
  end

  def create_order
    @cart.cart_items.each do |cart_item|
      @order.item_orders.create(order_id: @order.id, quantity: cart_item.quantity, item_id: cart_item.item_id, price: cart_item.item.price,
                                subtotal: cart_item.quantity * cart_item.item.price)
    end
    @cart.destroy
  end
end
