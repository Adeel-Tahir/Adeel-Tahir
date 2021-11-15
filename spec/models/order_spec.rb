# frozen_string_literal: true

RSpec.describe Order, type: :model do
  let(:user) { create(:user) }
  let(:order1) { create(:order, status: 'paid', user_id: user.id) }
  let(:order2) { create(:order, status: 'completed', user_id: user.id) }

  describe 'associations' do
    it { is_expected.to have_many(:item_orders).dependent(:destroy) }
    it { is_expected.to have_many(:items).through(:item_orders) }
    it { is_expected.to belong_to(:user).class_name('User') }
  end

  it do
    expect(subject).to define_enum_for(:status)
      .with_values(%i[ordered paid canceled completed])
  end

  describe '.filter_by_status' do
    it 'includes orders with ordered' do
      expect(described_class.filter_by_status(order1.status)).to include(order1)
    end

    it 'not includes orders with wrong status' do
      expect(described_class.filter_by_status(order1.status)).not_to include(order2)
    end
  end
end
