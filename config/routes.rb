Rails.application.routes.draw do
  root to: "users#index"
  resources :users
  resources :subs
  resource :session, only: [:new, :create, :destroy]
  resources :posts
end
