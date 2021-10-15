# frozen_string_literal: true

class Resturant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: { message: 'Please Enter Name' }

  has_one_attached :avatar
end
