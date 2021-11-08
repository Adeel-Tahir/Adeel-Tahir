# frozen_string_literal: true

class Category < ApplicationRecord
  include Concerns::Validatable

  has_many :categorizations, dependent: :destroy
  has_many :items, through: :categorizations

  has_one_attached :image
  validate :correct_image_type

  validates :name, presence: { message: ': Category name is blank' },
                   uniqueness: { message: ': Category name Must be unique' }
end
