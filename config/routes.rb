Rails.application.routes.draw do
  root to: 'rooms#index'

  # resources
  resources :rooms
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  delete 'friends/:id', to: 'friends#destroy', as: 'remove_friend'
  post 'friends/search', to: 'friends#search', as: 'search_friend'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
