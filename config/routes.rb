Rails.application.routes.draw do


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admin_users, controllers: {
    sessions:      'admin_users/sessions',
    passwords:     'admin_users/passwords',
    registrations: 'admin_users/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  # devise_for :users
  resources :users, :only => [:index, :show]
  # root "posts#index"
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]

  resources :posts
  resources :comments, only: [ :create, :destroy ]
  # resources :users, only: :show
  get 'comments' => redirect('posts')
  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
