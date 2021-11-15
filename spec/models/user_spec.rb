# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:orders).dependent(:destroy) }
    it { is_expected.to have_one(:cart) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:fullname) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  it do
    expect(subject).to define_enum_for(:status)
      .with_values(%i[admin user])
  end
end
