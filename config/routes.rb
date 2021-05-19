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
  post 'comment_like/:id' => 'comment_likes#create', as: 'create_comment_like'
  delete 'comment_like/:id' => 'comment_likes#destroy', as: 'destroy_comment_like'
end
