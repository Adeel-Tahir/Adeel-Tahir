# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :item_orders, dependent: :destroy
  has_many :orders, through: :item_orders
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  belongs_to :resturant

  has_one_attached :avatar

  validates :name, presence: { message: 'Please enter name' }
  validates :price, presence: { message: 'Please enter price' },
                    numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: { message: 'Please enter description' }

  enum status: { available: 0, outOfStock: 1 }

  scope :find_resturant_item, ->(resturant) { where(resturant_id: resturant) }

  def self.search(item_name)
    where("LOWER(name) LIKE '%#{item_name}%'")
  end
end
