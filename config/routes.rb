Rails.application.routes.draw do
  get 'greetings/hello'
  resources :friend_requests
  resources :friends, only: [:index, :destroy]
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :devices
  post '/checkout', to: 'devices#checkout'
  post '/checkin', to: 'devices#checkin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
