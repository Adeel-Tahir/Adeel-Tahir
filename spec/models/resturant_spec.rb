# frozen_string_literal: true

require 'rails_helper'
# require Rails.root.join 'spec/concerns/validatable_spec.rb'

RSpec.describe Resturant, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:items).dependent(:destroy) }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
