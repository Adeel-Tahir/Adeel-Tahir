# frozen_string_literal: true

class Resturant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_and_belongs_to_many :categories, dependent: :destroy
  validates :name, presence: { message: 'Please Enter Name' }
  # accepts_nested_attributes_for :items
  has_one_attached :avatar
end
