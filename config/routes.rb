Rails.application.routes.draw do
  devise_for :users

  root                        to: 'home#index'
  get  'product_items/entry', to: 'product_items#new_entry'
  post 'product_items/entry', to: 'product_items#process_entry'
  get  'warehouses',          to: 'warehouses#new'

  resources :product_bundles,    only: [:new, :create, :show]
  resources :product_categories, only: [:new, :create]
  resources :product_models,     only: [:new, :create, :show]
  resources :suppliers,          only: [:new, :create, :show, :index]
  resources :warehouses,         only: [:new, :create, :show, :edit, :update]

  namespace :api, format: 'json' do
    namespace :v1 do
      resources :warehouses, only: [:index]
    end
  end
end