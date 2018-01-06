Rails.application.routes.draw do
  root "static_pages#home"
  get "/login", to: "sessions#new"
  get "/signup", to: "users#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: %i(new create show)
  resources :products
end
