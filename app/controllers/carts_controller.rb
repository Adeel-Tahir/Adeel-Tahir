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
    flash[:notice] = 'Cart is Empty' if @cart.cart_items[0].nil?
  end

  def new
    @cart = Cart.new
  end

  def create
    @item = Item.find_by(id: params[:item])
    @res = @item.resturant
    @resturant = @res.items
    ActiveRecord::Base.transaction do
      if current_user
        cart_create
      else
        @cart = Cart.find_by(id: session[:cart])
      end
      find_cart_items
    end
  end

  def edit
    item = Item.find_by(id: params[:id])
    @cart = item.carts
  end

  def update
    @cart&.update!(cart_params)
    redirect_to carts_path, notice: 'Cart updated'
  rescue ActiveRecord::RecordInvalid => e
    render :edit, flash[:alert] = e.record.errors.full_messages[0]
  end

  def destroy
    if @cart&.destroy
      flash[:notice] = 'Cart Item deleted'
    else
      flash[:alert] = 'Cart Item not deleted'
    end
    redirect_to carts_path
  end

  private

  def cart_params
    params.require(:cart).permit(:id, :user_id, :total, item_ids: [])
  end

  def find_cart_items
    item = Item.find(params[:item])
    @cart.cart_items.create(item: item, quantity: 1)
    respond_to do |format|
      format.js if @cart.save
    end
  end

  def cart_create
    if Cart.find_by(user_id: current_user.id).nil?
      @cart = Cart.new(user_id: current_user.id)
      cart_check
    else
      @cart = Cart.find_by(user_id: current_user&.id)
    end
  end

  def cart_check
    @cart.save!
    flash[:notice] = 'Cart Item Created'
  rescue ActiveRecord::RecordNotSaved
    render :new, flash[:alert] = 'Cart Item cant be saved '
  end

  def find_cart
    @cart = Cart.find_by(id: params[:id])
  end

  def check_permission
    authorize Cart
  end
end
