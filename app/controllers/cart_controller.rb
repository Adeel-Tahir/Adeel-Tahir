# frozen_string_literal: true

class CartController < ApplicationController
  def index
   @cart=Cart.all
  end
  def new
    @cart=Cart.new
  end
  def create
    if !current_user
      @cart =Cart.new(my_params)
      @cart.save
      params_id= params[:item]
      puts params
      item = Item.find(params[:item])
      @cart.cart_items.create(item: item)
      redirect_to cart_index_path if @cart.save
    end
  end
  def destroy; end

  private

  def my_params
    params.permit(:quantity)
  end
end
