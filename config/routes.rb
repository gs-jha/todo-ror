Rails.application.routes.draw do
  resources :tasks
  # Defines the root path route ("/")
  root "home#index"

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  
  get 'tasks/:id/toggle_completed', to: 'tasks#toggle_completed'
  patch 'tasks/:id/position', to: 'tasks#position'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

   resources :users
end
