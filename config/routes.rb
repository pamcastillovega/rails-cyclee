Rails.application.routes.draw do
  get 'reports/create'
  devise_for :users
  root to: "lanes#index"
  post "/", to: "lanes#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :lanes do
    resources :reviews
    collection do
      get :sample, :journeyreview
    end
    member do
      get :color_update
    end
  end

  resources :users

  resources :reviews

  resources :parking_locations

  resources :parking_locations do
    resources :reports, only: %i[index new create]
    resources :parking_histories, only: %i[create]
  end

  namespace :api do
    resources :lanes, only: %i[index]
  end
end
