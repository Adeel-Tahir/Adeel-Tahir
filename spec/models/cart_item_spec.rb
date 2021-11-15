# frozen_string_literal: true

RSpec.describe CartItem, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:cart).class_name('Cart') }
    it { is_expected.to belong_to(:item).class_name('Item') }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:quantity) }
  end
end
