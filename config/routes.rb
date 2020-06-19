Rails.application.routes.draw do

  root "static_pages#home"
  get "static_pages/home", to: "static_pages#home"
  get "static_pages/adminpage", to: "static_pages#adminpage"
  get 'search_hotels/show', to: "search_hotels#show"
  get "auth/:provider/callback", to: "sessions#create_from_socialmedia"
  get '/redirect', to: 'example#redirect', as: 'redirect'
  get '/callback', to: 'example#callback', as: 'callback'
  get '/calendars', to: 'example#calendars', as: 'calendars'
  get '/events/:calendar_id', to: 'example#events', as: 'events', calendar_id: /[^\/]+/
  post '/events/:calendar_id', to: 'example#new_event', as: 'new_event', calendar_id: /[^\/]+/
  get 'auth/failure', to: redirect('/')

  resources :users, only: [:new, :create]

  namespace :admin do
    resources :hotels
    resources :cities
    resources :rooms
  end

  resources :galleries, only: [:new, :create, :index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :search_hotels, only: :show
  resources :bookings do
    get :client_bookings, on: :collection
    get :update_status, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
