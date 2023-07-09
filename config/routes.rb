Rails.application.routes.draw do
  get 'movie_reviews/new'
  get '/movies/search' => 'movies#search'
  delete '/movies/:id' => 'movies#destroy'
  get 'movies/new'
  get '/movies/:id' => 'movies#show'
  get 'password_resets/new'
  get 'password_resets/edit'
  root   "static_pages#home"
  get    "/help",    to: "static_pages#help"
  get    "/about",   to: "static_pages#about"
  get    "/contact", to: "static_pages#contact"
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :movies
  resources :movie_reviews, only: [:create, :show, :index, :edit, :destroy]
  resources :users do
    resources :movie_reviews, only: [:index]
  end
  get '/microposts', to: 'static_pages#home'
end