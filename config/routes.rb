Rails.application.routes.draw do
  get 'sessions/new'

  root to: 'tops#index'
  resources :tops
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :blogs do
   collection do
     post :confirm
   end
  end
end
