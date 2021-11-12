# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    status { 'ordered' }
    total { '1100' }
  end
end
