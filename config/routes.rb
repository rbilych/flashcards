Rails.application.routes.draw do
  root "reviews#new"

  resources :cards

  resources :reviews, only: [:new, :create]
  post "answer" => "reviews#create"

  resources :registrations, only: [:new, :create]

  resources :profiles, only: [:edit, :update]

  resources :sessions, only: [:new, :create, :destroy]
  get "/log_in", to: "sessions#new", as: :log_in
  delete "/log_out", to: "sessions#destroy", as: :log_out

  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider

  resources :decks
  post "change_current_state" => "decks#change_current_state"
end
