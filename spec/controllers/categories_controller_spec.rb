# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'
require 'faker'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user) }
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

  describe 'GET #index' do
    login_admin
    before do
      get :index
    end

    it 'returns 200:Ok' do
      expect(response).to have_http_status(:success)
    end

    it 'check response data count' do
      expect(assigns(:categories).count).to eq(Category.all.count)
    end
  end

  describe 'GET #new' do
    login_admin
    it 'returnses 200:Ok' do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'with unauthenticated user' do
      it 'does not authenticate' do
        post :create, params: { category: params }
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'with unauthorized user' do
      login_user
      it 'does not authorized' do
        post :create, params: { category: params }
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'with authenticated user ' do
      login_admin
      it 'responses redirect_to status' do
        post :create, params: { category: params }
        expect(response).to be_redirect
      end

      it 'shows create message' do
        post :create, params: { category: params }
        expect(flash[:notice]).to eq('Category Created')
      end

      it 'does not create cateory ' do
        post :create, params: { category: params2 }
        expect(flash[:alert]).to eq('Name has already been taken')
      end
    end
  end

  describe 'POST #update' do
    let(:category) { create(:category) }

    context 'with unauthenticated user' do
      it 'unauthenticate user' do
        patch :update, params: { id: category.id, category: params }
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'with unauthorized user' do
      login_user
      it 'unauthorizes user' do
        patch :update, params: { id: category.id, category: params }
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'with authenticated user' do
      let(:category2) { create(:category) }

      login_admin
      before do
        patch :update, params: { id: category2.id, category: params }
      end

      it 'responses redirect_to status' do
        expect(response).to be_redirect
      end

      it 'shows create message' do
        expect(flash[:notice]).to eq('Category Updated')
      end

      it 'does not create cateory ' do
        patch :update, params: { id: category2.id, category: params }
        expect(flash[:alert]).to eq('Image : Must be an image')
      end
    end
  end

  describe 'Delete #destroy' do
    let(:category3) { create(:category) }

    context 'with unauthenticed user' do
      it 'unautheticates user' do
        delete :destroy, params: { id: category3.id }
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'with unauthorize user' do
      login_user
      let(:category3) { create(:category) }

      it 'unauthorizes user' do
        delete :destroy, params: { id: category3.id }
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'with authenticated user' do
      login_admin
      context 'when correct category destroy' do
        before do
          delete :destroy, params: { id: category3.id }
        end

        it 'destroys category' do
          expect(Category.find_by(id: category3.id)).to be_nil
        end

        it 'shows delete message response' do
          expect(flash[:notice]).to eq('Category deleted')
        end
      end

      context 'when fail destroy' do
        let(:category4) { build_stubbed(:category) }

        it 'does not destroy category' do
          delete :destroy, params: { id: category4.id }
          expect(flash[:alert]).to eq('Category not deleted')
        end
      end
    end
  end
end
