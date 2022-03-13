Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "matches#new"
  resources :matches, only: [:new, :create, :show, :destroy] do
    member do
      get 'public'
      post 'timer'
    end
    resources :competitors, only: [:new, :create, :edit, :update] do
      resources :scores
    end
  end
end
