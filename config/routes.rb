Rails.application.routes.draw do
  get 'static_pages/schedule'

  get 'static_pages/contact'

  root 'static_pages#home'
end
