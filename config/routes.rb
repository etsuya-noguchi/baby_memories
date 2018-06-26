Rails.application.routes.draw do
  get 'favorites/create'

  get 'favorites/destroy'

  get 'favorite/create'
  
  get 'favorite/destroy'

  get 'sessions/new'

  root to: 'tops#index'
  resources :favorites, only: [:create, :destroy]
  resources :tops
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :blogs do
   collection do
     post :confirm
   end
  end
end
