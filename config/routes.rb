# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root                        to: 'home#index'
  get  'product_items/entry', to: 'product_items#new_entry'
  post 'product_items/entry', to: 'product_items#process_entry'
  get  'warehouses',          to: 'warehouses#new'

  resources :product_bundles,    only: %i[new create show]
  resources :product_categories, only: %i[new create]
  resources :product_models,     only: %i[new create show index edit update]
  resources :suppliers,          only: %i[new create show index]
  resources :warehouses,         only: %i[new create show edit update] do
    get 'search', on: :collection, to: 'home#search'
  end

  namespace :api, format: 'json' do
    namespace :v1 do
      resources :warehouses,     only: %i[index show create]
      resources :product_models, only: [:show]
    end
  end
end
