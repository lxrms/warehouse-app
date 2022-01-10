Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'warehouses', to: 'warehouses#new'
  resources :warehouses, only: [:show, :new, :create, :edit, :update]
  resources :suppliers, only: [:index, :show, :new, :create]
  resources :product_models, only: [:show, :new, :create]
  resources :product_bundles, only: [:new, :create, :show]
  resources :product_categories, only: [:new, :create]
end

