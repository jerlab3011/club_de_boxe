Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
  get '/inscription', to: 'users#new'
  post '/inscription',  to: 'users#create'
  get  '/programmation',    to: 'static_pages#schedule'
  get  '/contact',   to: 'static_pages#contact'
  get    '/connexion',   to: 'sessions#new'
  post   '/connexion',   to: 'sessions#create'
  delete '/deconnexion',  to: 'sessions#destroy'
  resources :users
end
