Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  resources :bookings, only: [:create]
  get '/confirmation', to: 'bookings#confirmation'
  post '/find_pro_for_existing_booking', to: 'bookings#find_pro_for_existing_booking', as: 'find_pro_bookings'
end
