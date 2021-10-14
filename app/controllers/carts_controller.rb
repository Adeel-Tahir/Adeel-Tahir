# frozen_string_literal: true

class CartsController < ApplicationController

  def index
    # byebug
    if current_user
       @cart=Cart.find_by(user_id: current_user.id)
    else
      @cart=Cart.find_by(id: session[:cart])
    end

  end

  def new
    @cart=Cart.new
  end

  def create
    if current_user
     create_cart()
    else
      cart_id=session[:cart]
      @cart=Cart.find(cart_id)
      find_cart_items()
    end
  end

  def update
    @cart = Cart.find(params[:id])
    if @cart.update(params_update)
      redirect_to carts_path
    else
      render :edit
    end
  end

  def edit
    item= Item.find(params[:id])
    @cart=item.carts

  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to carts_path
  end

  private

  def params_update
    params.require(:cart)
  end

  def find_cart_items
    params_id= params[:item]
    item = Item.find(params[:item])
    @cart.cart_items.create(item: item)
    # byebug
    redirect_to carts_path if @cart.save
  end

  def create_cart
    if Cart.find_by(user_id: current_user&.id).nil?
      @cart =Cart.new(user_id: current_user&.id)
      @cart.save
      find_cart_items()
    else
      @cart=Cart.find_by(user_id: current_user&.id)
      find_cart_items()
    end
  end
end
