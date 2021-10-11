# frozen_string_literal: true

class ItemOrder < ApplicationRecord
  belongs_to :item
  belongs_to :order
  before_save :set_price
  before_save :set_total

  def unit_price
    if persisted?
      self[:price]
    else
      item.price
    end
  end

  def total
    unit_price * quantity
  end

  private

  def set_price
    self[:price] = unit_price
  end

  def set_total
    self[:total] = total * quantity
  end
end
