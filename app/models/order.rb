# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :item_orders, dependent: :destroy
  has_many :items, through: :item_orders

  belongs_to :user

  enum status: { ordered: 0, paid: 1, canceled: 2, completed: 3 }
end
