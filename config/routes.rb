Longjohn::Application.routes.draw do

  get "log_out" => "sessions#destroy", as: "log_out"
  get "log_in" => "sessions#new", as: "log_in"
  get "sign_up" => "users#new", as: "sign_up"

  resources :users
  resources :sessions

  namespace :equipment do
    resources :models, only: [:index]
    resources :devices, only: [:index]
    resources :reservations
  end

  root :to => 'start#index'

end
