# frozen_string_literal: true

RSpec.describe Item, type: :model do
  let(:resturant) { create(:resturant) }
  let(:item) { create(:item, name: 'macdonal', resturant_id: resturant.id) }

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

  it 'check enum' do
    expect(subject).to define_enum_for(:status)
      .with_values(%i[Available OutofStock])
  end

  describe '.resturant item' do
    it 'equal items of resturant' do
      expect(described_class.find_resturant_item(resturant)).to eq(resturant.items)
    end
  end

  describe '.search item name' do
    it 'searches by name' do
      expect(described_class.search_item_name('macdonal')).to include(item)
    end

    it 'does not search by wrong name' do
      expect(described_class.search_item_name('KFC')).not_to include(item)
    end
  end
end
