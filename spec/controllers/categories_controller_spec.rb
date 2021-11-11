# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'
require 'faker'

RSpec.describe 'CategoriesController', type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:params) do
    {
      name: Faker::Name.name,
      image: Rack::Test::UploadedFile.new('app/assets/images/desi.jpg', 'desi/jpg')
    }
  end
  let(:params2) do
    {
      name: 'admin',
      image: Rack::Test::UploadedFile.new('app/assets/images/desi.jpg', 'desi/jpg')
    }
  end

  before do
    @category = Category.find_by(id: 110)
    @category_list = Category.all
    @controller = CategoriesController.new
  end

  describe 'GET #index' do
    login_admin
    before do
      get :index
    end

    it 'returns 200:Ok' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    login_admin
    before do
      get :new, xhr: true
    end

    it 'returns 200:Ok' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    login_admin

    before do
      post :create, params: { category: params }
    end

    context 'checking correct category' do
      it 'creates category' do
        expect(response).to be_redirect
      end

      it 'creates category response' do
        expect(flash[:notice]).to eq('Category Created')
      end
    end

    context 'checking wrong category' do
      it 'cannot create cateory ' do
        post :create, params: { category: params2 }
        expect(flash[:alert]).to eq('Name has already been taken')
      end
    end
  end

  describe 'POST #update' do
    login_admin

    before do
      patch :update, params: { id: @category.id, category: params }
    end

    context 'checking correct category update' do
      it 'update category' do
        expect(response).to be_redirect
      end

      it 'creates category response' do
        expect(flash[:notice]).to eq('Category Updated')
      end
    end

    context 'checking wrong category' do
      it 'cannot create cateory ' do
        patch :update, params: { id: @category.id, category: params }
        expect(flash[:alert]).to eq('Image : Must be an image')
      end
    end
  end

  describe 'Delete #destroy' do
    login_admin

    before do
      @category5 = create(:category)
      delete :destroy, params: { id: @category5.id }
    end

    context 'checking correct category destroy' do
      it 'destroy category' do
        expect(Category.find_by(id: @category5.id)).to be_nil
      end

      it 'creates category response' do
        expect(flash[:notice]).to eq('Category deleted')
      end
    end
    context 'failing the destroy function' do
      let(:category) { build_stubbed(:category) }
      before do
        allow(category).to receive(:destroy).and_return(false)
        allow(Category).to receive(:find).and_return(category)
      end

      it "renders delete" do
        delete :destroy, params: { id: category.id }
        expect(flash[:notice]).to eq('Category deleted')
      end
    end

  end
end
