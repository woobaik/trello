Rails.application.routes.draw do
  resources :cards
  resources :lists
  devise_for :users
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
