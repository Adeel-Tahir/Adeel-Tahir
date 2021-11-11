# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    price { Faker::Number.number(digits: 3) }
    description { Faker::String.random }
    image { Rack::Test::UploadedFile.new('app/assets/images/broast.jpg', 'broast/jpg') }
    status { 'Available' }
  end
end
