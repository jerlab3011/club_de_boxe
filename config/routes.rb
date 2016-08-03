Rails.application.routes.draw do
  root 'static_pages#home'
  get '/inscription', to: 'users#new'
  post '/inscription',  to: 'users#create'
  get  '/programmation',    to: 'static_pages#schedule'
  get  '/contact',   to: 'static_pages#contact'
  resources :users
end
