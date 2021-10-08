# frozen_string_literal: true

class Order < ApplicationRecord
  enum status: { ordered: 0, paid: 1, canceled: 2, completed: 3 }
  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders
end
