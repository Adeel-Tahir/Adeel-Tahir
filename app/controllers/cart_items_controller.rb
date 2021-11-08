# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :find_cart_item, only: %i[update destroy]

  def destroy
    if @cart_item&.destroy
      flash[:notice] = 'Cart Item deleted'
    else
      flash[:alert] = @cart_item.errors.full_messages.to_sentence
    end

    redirect_to carts_path
  end

  def update
    @cart_item&.update!(cart_item_params)
    redirect_to carts_path, notice: 'Item has been Updated'
  rescue ActiveRecord::RecordInvalid => e
    render :edit, flash[:alert] = e.record.errors.full_messages.to_sentence
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :subtotal)
  end

  def find_cart_item
    @cart_item = CartItem.find_by(id: params[:id])
  end
end
