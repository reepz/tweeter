Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  root 'static_pages#home'

  # StaticPages
  get '/help',      to: 'static_pages#help'
  get '/about',     to: 'static_pages#about'
  get '/contact',   to: 'static_pages#contact'

  # Users
  resources :users do
    member do
      get :following, :followers
    end
  end
  get '/signup',    to: 'users#new'
  post '/signup',   to: 'users#create'

  # Sessions
  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  # Account activations
  resources :account_activations, only: [:edit]

  # Password resets
  resources :password_resets,     only: [:new, :edit, :create, :update]

  # microposts
  resources :microposts,          only: [:create, :destroy]

  # relationships
  resources :relationships,       only: [:create, :destroy]
end
