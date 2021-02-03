Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index]
  get 'users/:id/follows' => 'users#follows', as: 'user_follows'
  get 'users/:id/followers' => 'users#followers', as: 'user_followers'
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  get 'search' => 'search#search', as: 'search'
end
