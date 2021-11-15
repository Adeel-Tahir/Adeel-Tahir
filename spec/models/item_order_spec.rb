# frozen_string_literal: true

RSpec.describe ItemOrder, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:item).class_name('Item') }
    it { is_expected.to belong_to(:order).class_name('Order') }
  end
end
