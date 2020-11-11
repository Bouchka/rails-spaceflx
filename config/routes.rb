Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :spaces do
    resources :bookings, only: [:create, :show]
  end
  resources :bookings, only: [:destroy]

  get '/dashboards/host', to: "dashboards#host", as: 'host_dashboard'
  get '/dashboards/user', to: "dashboards#user", as: 'user_dashboard'

end
