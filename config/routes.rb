Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  # eget 'prototypes/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  

   resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy] do
   resources :comments, only: :create
  end
   resources :users, only: :show
end