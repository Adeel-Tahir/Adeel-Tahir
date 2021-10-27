# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  def sub_total
    quantity * item.price
  end

  def calculate_total
    sum = 0
    cart_items.each do |line_item|
      sum += line_item.sub_total
    end
    sum
  end
end
