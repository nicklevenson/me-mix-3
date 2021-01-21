Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'feed#index'
  get '/welcome', to: 'welcome#index'
  get 'auth/:provider/callback', to: "sessions#omniauth"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  resources :contents, only: [:show, :destroy]
  resources :notes, only: [:destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:new, :create, :destroy]
  # resources :mixes
  resources :users do
    resources :mixes
    get '/following', to: 'users#following'
    get '/followers', to: 'users#followers'
  end
  resources :follow_relationships, only: [:create, :update, :destroy]

end
