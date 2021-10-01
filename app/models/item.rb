class Item < ApplicationRecord
  validates :name, presence: true
  has_many :item_orders
  has_many :orders, through: :item_orders
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :cart_items
  has_many :carts, through: :cart_items
end
