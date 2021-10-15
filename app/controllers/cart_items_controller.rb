# frozen_string_literal: true

class CartItemsController < ApplicationController
  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      flash[:notice] = 'Cart Item deleted'
    else
      flash[:alert] = 'Cart Item not deleted'
    end

    redirect_to carts_path
  end

  def update
    @cart = CartItem.find(params[:id])
    if @cart.update(cart_item_params)
      flash[:notice] = 'Cart Item Updated'
      redirect_to carts_path
    else
      render :edit, flash[:alert] = 'Cart Item not updated'
    end
  end

  def edit
    item = Item.find(params[:id])
    @cart = item.cart_items
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
