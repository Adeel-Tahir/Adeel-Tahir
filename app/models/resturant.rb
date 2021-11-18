# frozen_string_literal: true

class Resturant < ApplicationRecord
  include Concerns::Validatable

  has_many :items, dependent: :destroy

  validates :name, presence: true

  has_one_attached :image
  validate :correct_image_type
end
