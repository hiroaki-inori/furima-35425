Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: 'items#index'
  resources :items do
    resources :orders, only: [:index, :create]
    resources :comments, only: [:create]
    resources :likes, only: [:destroy]
  end
  post 'like/:id' => 'likes#create', as: 'create_like'
  # post "likes/:item_id/create", to: "likes#create", constraints: {item_id: /\d+/}, as: :likes_create
  # post "likes/:item_id/delete", to: "likes#delete", constraints: {item_id: /\d+/}, as: :likes_delete
end
