Rails.application.routes.draw do
  get 'home/home'
  get 'home/about'
  root to: "books#index"
  devise_for :users
  resources :users ,only: [:index, :show, :edit,:update]
  resources :books
  # ,only:[:new, :create, :index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
