Rails.application.routes.draw do
  get 'reports/create'
  devise_for :users
  root to: "lanes#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :lanes do
    resources :reviews
    collection do
      get :sample
    end
  end

  resources :users do
    resources :parking_histories, only: %i[show]

  end

  resources :parking_locations do
    resources :reports, only: %i[index new create]
    resources :parking_histories, only: %i[new create]
  end

  resources :reviews

  resources :parking_histories do
    resources :users
    resources :parking_locations
  end
end
