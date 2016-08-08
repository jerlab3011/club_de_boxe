Rails.application.routes.draw do
  get 'payments/create'

  get 'payments/destroy'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  root 'static_pages#home'
  get '/inscription', to: 'users#new'
  get  '/programmation',    to: 'static_pages#schedule'
  get  '/contact',   to: 'static_pages#contact'
  get    '/connexion',   to: 'sessions#new'
  post   '/connexion',   to: 'sessions#create'
  delete '/deconnexion',  to: 'sessions#destroy'
  get '/abonnements_actifs', to: 'memberships#active'
  get '/users_stats', to: 'users#stats'
  get '/memberships_stats', to: 'memberships#stats'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :memberships,         only: [:create, :destroy]
  resources :payments,            only: [:create, :destroy]
end
