Rails.application.routes.draw do
  get 'signup', to: 'users#new'
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "home#index"

   resources :users
end
