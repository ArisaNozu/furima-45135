Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :orders, only: [:index, :create]
  resources :products
end


