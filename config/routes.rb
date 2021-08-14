Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/index'
  get 'stocks/market'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :stocks do
    resources :orders
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
