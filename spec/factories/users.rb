# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    fullname { Faker::Name.name }
    email { Faker::Internet.email }
    status { 'admin' }
    password { Faker::Internet.password }
  end
  # factory :user, class: User do
  #   fullname { Faker::Name.fullname }
  #   status {"user"}
  #   email { Faker::Internet.email }
  #   password {Faker::Internet.password}
  # end
end
