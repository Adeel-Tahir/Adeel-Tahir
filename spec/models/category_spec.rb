# frozen_string_literal: true

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:categorizations).dependent(:destroy) }
    it { is_expected.to have_many(:items) }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:category) }

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
