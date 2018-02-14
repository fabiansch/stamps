Rails.application.routes.draw do
  resources :stamps
  resources :transactions
  resources :vendors
  resources :cards
  resources :addresses
  resources :companies
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root to: "pages#home"
end
