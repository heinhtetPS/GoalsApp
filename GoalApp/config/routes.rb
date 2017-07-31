Rails.application.routes.draw do
  resources :users
  resources :goals
  resource :session 
end
