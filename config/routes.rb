Longjohn::Application.routes.draw do

  get "log_out" => "sessions#destroy", as: "log_out"
  get "log_in" => "sessions#new", as: "log_in"
  get "sign_up" => "users#new", as: "sign_up"

  resources :users
  resources :sessions

  namespace :equipment do
    resources :reservations
    resources :pick_ups
    resources :returns
  end

  root :to => 'start#index'

end
