# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :resturants do
    resources :items
  end
  resources :cart

  resources :item_orders

  # resources :cart_items
  resources :categories
end
