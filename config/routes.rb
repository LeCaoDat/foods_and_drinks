Rails.application.routes.draw do
  root "static_pages#home"
  get "/signup", to: "users#new"
  resources :users, only: %i(new create show)
  resources :products
end
