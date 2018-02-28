Rails.application.routes.draw do
  root to: "pages#home"

  resources :stamps
  resources :stampings
  resources :vendors
  resources :cards
  resources :addresses
  resources :companies

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  get 'vending_session/new', to: 'vending_sessions#new'
  post 'vending_sessions', to: 'vending_sessions#create'
end
