# frozen_string_literal: true

class Item < ApplicationRecord
  include Concerns::Validatable

  has_many :item_orders, dependent: :destroy
  has_many :orders, through: :item_orders
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  belongs_to :resturant

  has_one_attached :image
  validate :correct_image_type

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true

  enum status: { Available: 0, OutofStock: 1 }

  scope :find_resturant_item, ->(resturant) { where(resturant_id: resturant) }
  scope :search_item_name, ->(item_name) { where("LOWER(name) LIKE '%#{item_name}%'") }
end
