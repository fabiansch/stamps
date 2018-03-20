Rails.application.routes.draw do

  resources :stamps
  resources :stampings
  resources :vendors
  resources :cards
  resources :addresses
  resources :companies

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  root to: "pages#home"

  namespace :api, defaults: { format: :json } do
    scope :v1 do
      mount_devise_token_auth_for "User", at: "auth", skip: [:omniauth_callbacks]
      resources :stampings
      get  'home', to: "pages#home"
      get  'vending_session/new', to: 'vending_sessions#new'
      post 'vending_sessions', to: 'vending_sessions#create'
    end
  end

  get 'vending_session/new', to: 'vending_sessions#new'
  post 'vending_sessions', to: 'vending_sessions#create'
end
