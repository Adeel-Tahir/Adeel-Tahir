# frozen_string_literal: true

RSpec.describe ItemsController, type: :controller do
  let(:resturant) { create(:resturant) }

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

  describe 'GET #index' do
    let(:category) { create(:category) }

    before do
      login_admin
    end

    it 'returnses 200:Ok' do
      get :index, params: { resturant_id: resturant.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns success status' do
      get :index, params: { resturant_id: resturant.id, cate: category.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    context 'with unauthenticated user' do
      it 'does not authorized' do
        get :new, params: { resturant_id: resturant.id }
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'when unautherized user' do
      it 'does not authorized' do
        login_user
        get :new, params: { resturant_id: resturant.id }
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'with authenticated user ' do
      before do
        login_admin
        get :new, params: { resturant_id: resturant.id }
      end

      it 'returns 200:Ok' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST #create' do
    context 'when unauthenticated user' do
      it 'does not authenticate' do
        post :create, params: { resturant_id: resturant.id, item: params }
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'when unauthorized user' do
      it 'noys authorize' do
        login_user
        post :create, params: { resturant_id: resturant.id, item: params }
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'when authenticated user ' do
      before do
        login_admin
        post :create, params: { resturant_id: resturant.id, item: params2 }
      end

      it 'returns found status' do
        post :create, params: { resturant_id: resturant.id, item: params }
        expect(response).to have_http_status(:found)
      end

      it 'shows item message' do
        post :create, params: { resturant_id: resturant.id, item: params }
        expect(flash[:notice]).to eq('Item Created')
      end

      it 'does not create item message' do
        post :create, params: { resturant_id: resturant.id, item: params2 }
        expect(flash[:alert]).to eq("Image : Must be an image and Name can't be blank")
      end
    end
  end

  describe 'GET #show' do
    let(:item4) { create(:item, resturant_id: resturant.id) }

    context 'when correct show item' do
      it 'returnses status ok' do
        login_user
        get :show, params: { id: item4.id, resturant_id: resturant.id, item: params }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #update' do
    let(:category) { create(:category) }
    let(:item) { create(:item, category_ids: ['', category.id.to_s], resturant_id: resturant.id) }

    before do
      login_admin
    end

    it 'returns found status' do
      patch :update, params: { item: params, id: item.id, resturant_id: resturant.id }
      expect(response).to have_http_status(:found)
    end

    it 'shows update message' do
      patch :update, params: { item: params, id: item.id, resturant_id: resturant.id }
      expect(flash[:notice]).to eq('Item Updated')
    end

    it 'does not update item ' do
      patch :update, params: { item: params2, id: item.id, resturant_id: resturant.id }
      expect(flash[:alert]).to eq(["Name can't be blank"])
    end
  end

  describe 'Delete #destroy' do
    let(:item2) { create(:item, resturant_id: resturant.id) }

    context 'with unauthenticed user' do
      it 'unautheticates user' do
        delete :destroy, params: { id: item2.id, resturant_id: item2 }
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'with unauthorized user' do
      it 'unauthorizes user' do
        login_user
        delete :destroy, params: { id: item2.id, resturant_id: item2 }
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end

    context 'with authenticated user' do
      before do
        login_admin
        delete :destroy, params: { id: item2.id, resturant_id: item2 }
      end

      context 'when correct item destroy' do
        it 'destroys item' do
          expect(Item.find_by(id: item2.id)).to be_nil
        end

        it 'shows delete message' do
          expect(flash[:notice]).to eq('Item deleted')
        end
      end

      context 'when fail destroy ' do
        let(:item3) { build_stubbed(:item, resturant_id: resturant.id) }

        it 'does not destroy item' do
          delete :destroy, params: { id: item3.id, resturant_id: resturant.id }
          expect(flash[:alert]).to eq('item not deleted')
        end
      end
    end
  end
end
