Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  
  get "home/index"
  resources :deposits, only: [:new, :create]
  resources :withdrawals, only: [:new, :create]
  resources :transferences, only: [:new, :create]
  resources :bank_statements, only: [:index]
  resources :cancel_accounts, only: [:destroy]
  
end
