# frozen_string_literal: true

Rails.application.routes.draw do
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  devise_for :users, controllers: { sessions: 'devise_sessions' }
  root to: 'resturants#index'
  resources :resturants do
    resources :items
  end
  resources :carts, except: :show
  resources :cart_items, only: %i[update destroy edit]

  resources :item_orders, :categories

  resources :orders, only: %i[index new update create show]
end
