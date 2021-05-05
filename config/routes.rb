Rails.application.routes.draw do
  root to: 'pages#index'
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  authenticated :user do
    delete 'friends/:id', to: 'friends#destroy', as: 'remove_friend'
    post 'friends/search', to: 'friends#search', as: 'search_friend'

    resources :rooms
    
    scope 'rooms/:id' do
      post '/:user_id', to: 'rooms#add_participant', as: 'add_participant'
      delete '/:user_id', to: 'rooms#destroy_participant', as: 'destroy_participant'
      delete '/:user_id/exit', to: 'rooms#left_room', as: 'left_room'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
