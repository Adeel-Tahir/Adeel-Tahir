# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'devise_sessions' }
  root to: 'resturants#index'
  resources :resturants do
    resources :items
  end
  resources :carts
  resources :cart_items, only: %i[update destroy edit]

  resources :item_orders, :categories, :orders
end
