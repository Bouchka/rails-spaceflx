Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
<<<<<<< HEAD
  resources :spaces, only: [:index, :show] #do
 # resources :bookings, only: [:create]
 # resources :users, only: [:create]

=======
  resources :spaces, only: [:show, :new, :create]
>>>>>>> 5f68bdf8d2498d9899e18669fb845b1c71c2a361
end
