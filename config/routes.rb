Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  namespace :admin do
    resources :reservations
    resources :movies do
      resources :schedules, only: [:new, :create]
    end
    resources :schedules, only: [:index, :show, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :movies
  get '/movies/:movie_id/reservation', to: 'movies#reservation', as: 'reservation'
  get '/movies/:movie_id/schedules/:schedule_id/reservations/new', to: 'reservations#new', as: 'reservations_new'
  post '/reservations', to: 'reservations#create'

  resources :sheets
end
