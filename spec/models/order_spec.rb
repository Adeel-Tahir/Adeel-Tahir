# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:item_orders).dependent(:destroy) }
    it { is_expected.to have_many(:items).through(:item_orders) }
    it { is_expected.to belong_to(:user).class_name('User') }
  end

  it do
    expect(subject).to define_enum_for(:status)
      .with_values(%i[ordered paid canceled completed])
  end
  describe ".filter_by_status" do
    it "includes orders with ordered" do
      user=create(:user)
      order=create(:order,user_id: user.id)
      expect(Order.filter_by_status(order.status)).to include(order)
    end
  end
end
