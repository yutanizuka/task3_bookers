Rails.application.routes.draw do

  root to: "home#index"
  get 'home/about' => 'home#about'
  resources :home, only: [:index, :about]
  devise_for :users

  resources :users ,only: [:index, :show, :edit,:update]
  resources :books
  # ,only:[:new, :create, :index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
