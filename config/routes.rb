Rails.application.routes.draw do
  get '/inscription', to: 'users#new'

  root 'static_pages#home'
  get  '/programmation',    to: 'static_pages#schedule'
  get  '/contact',   to: 'static_pages#contact'
end
