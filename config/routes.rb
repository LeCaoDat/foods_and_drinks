Rails.application.routes.draw do
  root "static_pages#home"
  get "/login", to: "sessions#new"
  get "/signup", to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search", to: "filters#show"
  get "/orders", to: "orders#index"
  resources :users, except: %i(index destroy)
  resources :products
  resources :ratings, only: [:create]
  resources :comments, only: [:create]
  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index show destroy)
  resources :order_details, only: [:show]
  namespace :admin do
    root "static_pages#index"
    resources :categories, except: %i(show)
  end
end
