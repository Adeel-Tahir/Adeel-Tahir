# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :check_authentication, only: %i[index new update create show]
  before_action :find_order, only: %i[update show]

  def index
    if current_user.user?
      @orders = current_user.orders
    elsif current_user.admin?
      @orders = Order.includes(:user)
    end

    @orders = @orders.filter_by_status(params[:status]) if params[:status].present?
  end

  def new
    @order = Order.new
  end

  def create
    @cart = current_user.cart
    @cart_items = @cart.items
    ActiveRecord::Base.transaction do
      @order = Order.new(user_id: current_user&.id, status: 0, total: @cart.total)
      @order.save!
      order_item_create
    end
    redirect_to orders_path, notice: 'Thank you for Ordering,Order Confirmed'
  end

  def update
    @order&.update!(order_params)
    redirect_to orders_path, notice: 'Order Item updated'
  rescue ActiveRecord::RecordInvalid => e
    render :edit, flash[:alert] = e.record.errors.full_messages.to_sentence
  end

  def show
    redirect_to orders_path, alert: 'Order not Found' if @order.nil?
  end

  private

  def order_params
    params.require(:order).permit(:total, :status)
  end

  def check_authentication
    authenticate_user!
  end

  def order_item_create
    @cart.cart_items.each do |cart_item|
      @order.item_orders.create(order_id: @order.id, quantity: cart_item.quantity, item_id: cart_item.item_id,
                                price: cart_item.item.price, subtotal: cart_item.quantity * cart_item.item.price)
    end
    @cart.destroy
  end

  def find_order
    @order = Order.find_by(id: params[:id])
  end
end
