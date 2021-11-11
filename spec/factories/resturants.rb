# frozen_string_literal: true

FactoryBot.define do
  factory :resturant do
    name { Faker::Name.name }
    image { Rack::Test::UploadedFile.new('app/assets/images/broast.jpg', 'broast/jpg') }
  end
end
