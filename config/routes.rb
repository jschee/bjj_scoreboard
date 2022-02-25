Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "matches#new"
  resources :matches, only: [:new, :create, :show, :destroy] do
    resources :competitors, only: [:new, :create, :edit, :update]
  end
  resources :scores
end
