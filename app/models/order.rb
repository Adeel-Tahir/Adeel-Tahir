class Order < ApplicationRecord
  enum status: [ :ordered, :paid, :canceled, :completed]
  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders
end
