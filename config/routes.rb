# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :resturants do
    resources :items
  end

  resources :categories
  # do
  #   resources :items
  # end
  # do
  #   resources :items
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
