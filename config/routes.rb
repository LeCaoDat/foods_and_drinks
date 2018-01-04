Rails.application.routes.draw do
  root "static_pages#home"
  get "/login", to: "sessions#new"
  get "/signup", to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search", to: "filters#show"
  resources :users, only: %i(new create show)
  resources :products
  resources :ratings, only: [:create]
  resources :comments, only: [:create]
end
