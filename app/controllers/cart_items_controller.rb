# frozen_string_literal: true

class CartItemsController < ApplicationController
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to carts_path
  end

  def update
    @cart = CartItem.find(params[:id])
    if @cart.update(params_update)
      redirect_to carts_path
    else
      render :edit
    end
  end

  def edit
    item = Item.find(params[:id])
    @cart = item.cart_items
  end

  private

  def params_update
    params.require(:cart_item).permit(:quantity)
  end
end
