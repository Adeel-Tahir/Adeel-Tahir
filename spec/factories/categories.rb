# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Name.name }
    image { Rack::Test::UploadedFile.new('app/assets/images/desi.jpg', 'desi/jpg') }
  end
end
