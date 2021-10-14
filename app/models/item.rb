# frozen_string_literal: true

class Item < ApplicationRecord
  validates :name, presence: { message: 'Please enter name' }
  validates :price, presence: { message: 'Please enter price' }
  validates :description, presence: { message: 'Please enter description' }
  validates :price, numericality: true

  has_many :item_orders, dependent: :destroy
  has_many :orders, through: :item_orders, dependent: :destroy
  has_many :categorizations, dependent: :destroy, dependent: :destroy
  has_many :categories, through: :categorizations, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items, dependent: :destroy

  belongs_to :resturant

  has_one_attached :avatar

  enum status: { available: 0, outOfStock: 1 }

  def self.search(params)
    # byebug
    # where("LOWER(name) LIKE '%#{zinger}%'")
    left_joins(:categories).where('LOWER(items.name) LIKE :term OR LOWER(categories.name) LIKE :term',
                                  term: "%#{params}%")
  end

  def self.filter1(params)
    joins(:categories).where('categories.id = ?', params)
  end
end
