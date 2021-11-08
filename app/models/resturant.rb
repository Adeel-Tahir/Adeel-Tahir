# frozen_string_literal: true

class Resturant < ApplicationRecord
  include Concerns::Validatable

  has_many :items, dependent: :destroy

  validates :name, presence: { message: ': Resturant name is blank' }

  has_one_attached :image
  validate :correct_image_type
end
