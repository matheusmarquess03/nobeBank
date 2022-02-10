Rails.application.routes.draw do
  devise_for :users
  get "home/index"
  resources :deposits, only: [:new, :create]
  resources :withdrawals, only: [:new, :create]
  resources :transferences, only: [:new, :create]
  resources :bank_statements, only: [:index]
  resources :cancel_accounts, only: [:destroy]
  root to: "home#index"
end
