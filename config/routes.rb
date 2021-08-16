Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/index'
  get 'stocks/market'
  get 'orders/all'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :stocks, except: [:show] do
    resources :orders, only: [:new, :create, :edit, :update]
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
