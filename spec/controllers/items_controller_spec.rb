# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'
require 'faker'

RSpec.describe 'ItemsController', type: :controller do
  let(:resturant) { create(:resturant) }
  let(:item) { create(:item) }
  let(:categories) { Category.all }

  let(:params) do
    {
      name: Faker::Name.name,
      price: Faker::Number.number(digits: 3),
      description: Faker::String.random,
      image: Rack::Test::UploadedFile.new('app/assets/images/broast.jpg', 'broast/jpg'),
      status: 'Available',
      category_ids: ['', '279']
    }
  end
  let(:params2) do
    {
      name: '',
      price: Faker::Number.number(digits: 3),
      description: Faker::String.random,
      image: Rack::Test::UploadedFile.new('app/assets/images/broast.jpg', 'broast/jpg'),
      status: 'Available',
      category_ids: ['', '279']
    }
  end

  before do
    @category_list = Category.all
    @item = Item.find_by(id: 1)
    @controller = ItemsController.new
  end

  describe 'GET #index' do
    login_admin
    before do
      @resturant = create(:resturant)
    end

    it 'returns 200:Ok' do
      get :index, params: { resturant_id: @resturant.id }
      expect(response).to have_http_status(:success)
    end

    it 'items by  category status' do
      @category = create(:category)
      @item = create(:item, category_ids: ['', @category.id.to_s], resturant_id: @resturant.id)
      get :index, params: { resturant_id: @resturant.id, cate: @category.id }, xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    login_admin
    before do
      @resturant = create(:resturant)
      get :new, params: { resturant_id: @resturant.id }, xhr: true
    end

    it 'returns 200:Ok' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    login_admin
    context 'checking correct item' do
      before do
        @resturant = create(:resturant)
        post :create, params: { resturant_id: @resturant.id, item: params }
      end

      it 'returns 302 status' do
        expect(response).to have_http_status(:found)
      end

      it 'creates item message' do
        expect(flash[:notice]).to eq('Item Created')
      end
    end

    context 'checking wrong item' do
      before do
        @resturant = create(:resturant)
        post :create, params: { resturant_id: @resturant.id, item: params2 }
      end

      it 'cannot create item ' do
        expect(flash[:alert]).to eq("Name can't be blank")
      end

      it 'returns 302 status' do
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'GET #show' do
    login_user

    context 'checking correct show item' do
      before do
        @resturant = create(:resturant)
        @item = create(:item, resturant_id: @resturant.id)
      end

      it 'returns 204 status' do
        get :show, params: { id: @item.id, resturant_id: @resturant.id, item: params }, xhr: true
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'POST #update' do
    login_admin

    context 'checking correct item update' do
      before do
        @resturant = create(:resturant)
        patch :update, params: { item: params, id: @item.id, resturant_id: @resturant.id }
      end

      it 'returns 302 status' do
        expect(response).to have_http_status(:found)
      end

      it 'creates category response' do
        expect(flash[:notice]).to eq('Item Updated')
      end
    end

    context 'checking wrong item' do
      before do
        @resturant = create(:resturant)
        patch :update, params: { item: params2, id: @item.id, resturant_id: @resturant.id }
      end

      it 'returns 302 status' do
        expect(response).to have_http_status(:found)
      end

      it 'cannot create item ' do
        expect(flash[:alert]).to eq(["Name can't be blank"])
      end
    end
  end

  describe 'Delete #destroy' do
    login_admin
    before do
      @resturant = create(:resturant)
      @item = create(:item, resturant_id: @resturant.id)
      delete :destroy, params: { id: @item.id, resturant_id: @item }
    end

    context 'checking correct category destroy' do
      it 'destroy category' do
        expect(Item.find_by(id: @item.id)).to be_nil
      end

      it 'creates category response' do
        expect(flash[:notice]).to eq('Item deleted')
      end
    end
    context 'failing the destroy function' do
      let(:item) { build_stubbed(:item,resturant_id: @resturant.id) }
      before do
        allow(item).to receive(:destroy).and_return(false)
        allow(Item).to receive(:find).and_return(item)
      end

      it "not destroy item" do
        delete :destroy, params: { id: item.id,resturant_id: @resturant.id }
        expect(response).to have_http_status(:found)
      end
    end
  end
end
