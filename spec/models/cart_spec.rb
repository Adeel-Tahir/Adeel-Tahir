# frozen_string_literal: true

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:cart_items).dependent(:destroy) }
    it { is_expected.to have_many(:items).through(:cart_items) }
  end
end
