# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :find_cart, only: %i[update destroy]
  before_action :check_permission, only: %i[update destroy index new create]

  def index
    @cart = if current_user
              Cart.find_by(user_id: current_user.id)
            else
              Cart.find_by(id: session[:cart])

            end
    flash[:notice] = 'Cart is Empty' if @cart.cart_items.blank?
  end

  def new
    @cart = Cart.new
  end

  def create
    @item = Item.find_by(id: params[:item])
    @resturant = @item.resturant.items
    ActiveRecord::Base.transaction do
      @cart = if current_user
                Cart.find_or_create_by(user_id: current_user.id)
              else
                Cart.find_by(id: session[:cart])
              end
      cart_items_create
    end
  end

  def update
    @cart&.update!(cart_params)
    redirect_to carts_path, notice: 'Cart updated'
  rescue ActiveRecord::RecordInvalid => e
    render :edit, flash[:alert] = e.record.errors.full_messages.to_sentence
  end

  def destroy
    if @cart&.destroy
      flash[:notice] = 'Cart Item deleted'
    else
      flash[:alert] = @cart.errors.full_messages.to_sentence
    end
    redirect_to carts_path
  end

  private

  def cart_params
    params.require(:cart).permit(:id, :user_id, :total, item_ids: [])
  end

  def cart_items_create
    item = Item.find(params[:item])
    @cart.cart_items.create(item: item, quantity: 1)
    respond_to do |format|
      format.js if @cart.save
    end
  end

  def find_cart
    @cart = Cart.find_by(id: params[:id])
  end

  def check_permission
    authorize Cart
  end
end
