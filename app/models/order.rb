# frozen_string_literal: true

class Order < ApplicationRecord
  scope :filter_by_status, ->(status) { where status: status }

  has_many :item_orders, dependent: :destroy
  has_many :items, through: :item_orders

  belongs_to :user

  enum status: { ordered: 0, paid: 1, canceled: 2, completed: 3 }

  def self.filter1(params)
    joins(:statuses).where('status = ?', params)
  end
  # def self.search(params)
  #   where("LOWER(name) LIKE '%#{params}%'")
  # end
end
