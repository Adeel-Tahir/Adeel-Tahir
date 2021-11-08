# frozen_string_literal: true

module Concerns
  module Validatable
    extend ActiveSupport::Concern

    def correct_image_type
      return unless image.attached? && !image.content_type.in?(%w[image/jpg image/jpeg image/png image/gif])

      errors.add(:image, ': Must be an image')
    end
  end
end
