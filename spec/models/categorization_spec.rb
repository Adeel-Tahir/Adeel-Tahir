# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Categorization, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:category).class_name('Category') }
    it { is_expected.to belong_to(:item).class_name('Item') }
  end
end
