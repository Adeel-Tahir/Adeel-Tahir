# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { ordered: 0, paid: 1, canceled: 2, completed: 3 }
  
  belongs_to :user

  has_many :item_orders
  has_many :items, through: :item_orders

  before_save :set_total

  def total
    item_orders.collect { |item_order| item_order.valid? ? item_order.price * item_order.quantity : 0 }.sum
  end

  private

  def set_total
    total = subtotal
  end
end
