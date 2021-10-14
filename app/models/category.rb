# frozen_string_literal: true

class Category < ApplicationRecord
  has_and_belongs_to_many :resturants, dependent: :destroy

  has_many :categorizations, dependent: :destroy
  has_many :items, through: :categorizations, dependent: :destroy

  has_one_attached :avatar
end
