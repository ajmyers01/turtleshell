Rails.application.routes.draw do
  root 'home#index'

  get 'home/index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  delete 'logout', to: 'sessions#destroy'

  resources :users, only: [:create, :edit, :new, :update]
end
