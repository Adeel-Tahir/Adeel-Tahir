# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user, optional: true

  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, dependent: :destroy

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
