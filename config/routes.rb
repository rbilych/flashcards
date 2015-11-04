Rails.application.routes.draw do
  scope module: "home" do
    resources :registrations, only: [:new, :create]

    resources :sessions, only: [:new, :create, :destroy]
    get "/log_in", to: "sessions#new", as: :log_in
    delete "/log_out", to: "sessions#destroy", as: :log_out

    get "oauth/callback" => "oauths#callback"
    get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
  end

  scope module: "dashboard" do
    root "reviews#new"

    resources :cards, except: :show

    resources :reviews, only: [:new, :create]
    post "answer" => "reviews#create"

    resources :profiles, only: [:edit, :update]

    resources :decks
    post "set_current" => "decks#set_current"
  end
end
