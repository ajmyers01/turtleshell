Rails.application.routes.draw do
  root 'tasks#index'

  get 'home/index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  delete 'logout', to: 'sessions#destroy'

  match 'complete_task' => 'tasks#complete_task', :via => :post
  match 'delete_task' => 'tasks#destroy', :via => :post

  resources :tasks
  resources :users, only: [:create, :edit, :new, :update]
end
