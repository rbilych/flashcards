Rails.application.routes.draw do
  root "reviews#new"

  resources :cards

  resources :reviews, only: [:new, :create]
  post "answer" => "reviews#create"

  resources :users, only: [:new, :edit, :create, :update]
  get '/sign_up', to: 'users#new', as: :sign_up

  resources :sessions, only: [:new, :create, :destroy]
  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out
end
