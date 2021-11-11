# frozen_string_literal: true

require 'rails_helper'
require Rails.root.join 'spec/concerns/validatable_spec.rb'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:item_orders).dependent(:destroy) }
    it { is_expected.to have_many(:orders).through(:item_orders) }
    it { is_expected.to have_many(:categorizations).dependent(:destroy) }
    it { is_expected.to have_many(:categories).through(:categorizations) }
    it { is_expected.to have_many(:cart_items).dependent(:destroy) }
    it { is_expected.to have_many(:carts).through(:cart_items) }
    it { is_expected.to belong_to(:resturant).class_name('Resturant') }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'validations' do
    %i[name price description].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
    it { is_expected.to validate_numericality_of(:price) }
  end

  it do
    expect(subject).to define_enum_for(:status)
      .with_values(%i[Available OutofStock])
  end

  describe ".resturant item" do
    it "equal items of resturant" do
      resturant=create(:resturant)
      item=create(:item,resturant_id: resturant.id)
      resturant_items=resturant.items
      expect(Item.find_resturant_item(resturant)).to eq(resturant_items)
    end
  end

  describe ".search item name" do
    it "equal items of resturant" do
      resturant=create(:resturant)
      item=create(:item,resturant_id: resturant.id)
      item_name=item.name.downcase
      search_item=Item.where("LOWER(name) LIKE '%#{item_name}%'")
      expect(Item.search_item_name(item_name)).to eq(search_item)
    end
  end
end
