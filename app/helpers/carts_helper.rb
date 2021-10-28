# frozen_string_literal: true

module CartsHelper
  def sub_total(cart_item)
    cart_item.quantity * cart_item.item.price
  end

  def calculate_total(cart)
    sum = 0
    cart.cart_items.each do |line_item|
      sum += sub_total(line_item)
    end
    sum
  end
end
