Rails.application.routes.draw do
  devise_for :users
  resources :users
  get 'items/index'
  root to: "items#index"
end
