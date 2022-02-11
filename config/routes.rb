# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  get 'home/index'
  resources :deposits, only: %i[new create]
  resources :withdrawals, only: %i[new create]
  resources :transferences, only: %i[new create]
  resources :bank_statements, only: [:index]
  resources :cancel_accounts, only: [:destroy]
  patch :close_account, to: 'cancel_accounts#close_account'
end
