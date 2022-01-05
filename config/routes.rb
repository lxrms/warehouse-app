Rails.application.routes.draw do
  root to: 'home#index'
  get 'warehouses', to: 'warehouses#new'
  resources :warehouses, only: [:show, :new, :create]
end
