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
  get   '/statistiques', to: 'static_pages#stats'
  get    '/connexion',   to: 'sessions#new'
  post   '/connexion',   to: 'sessions#create'
  delete '/deconnexion',  to: 'sessions#destroy'
  get '/abonnements_actifs', to: 'memberships#active'
  get '/tarifs', to: 'static_pages#prices'
  resources :users
  resources :members, only: [:edit, :show, :index, :create, :update, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :memberships,         only: [:create, :destroy, :index]
  resources :payments,            only: [:create, :destroy]
end
