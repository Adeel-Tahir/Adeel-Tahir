# frozen_string_literal: true

class Order < ApplicationRecord
  scope :filter_by_status, ->(status) { where status: status }

  has_many :item_orders, dependent: :destroy
  has_many :items, through: :item_orders

  belongs_to :user

  enum status: { ordered: 0, paid: 1, canceled: 2, completed: 3 }

  def self.filter_order_status(params)
    joins(:statuses).where('status = ?', params)
  end
end
