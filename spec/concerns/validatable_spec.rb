# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'validatable' do
  let(:model) { described_class }

  it 'has correct image type' do
    model = FactoryBot.build(image: Rack::Test::UploadedFile.new('app/assets/images/broast.jpg', 'broast/jpg'))
    expect(model.image.valid?).to true
  end
end
