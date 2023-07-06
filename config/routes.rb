# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"

  resources :register, only: [:index]
  resources :users, only: [:index, :show, :create], controller: "users"

  # post "/users/:id/discover", to: "users#create"
  get "/users/:id/discover", to: "users/discover#index"
  get "/users/:id/movies", to: "users/movies#index"

end
