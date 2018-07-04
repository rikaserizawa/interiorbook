Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :users, only: [:show, :new, :create, :edit, :destroy, :update]do
    member do
      get :scraps
    end
  end
  
  resources :interiors, only: [:show, :create, :edit, :destroy, :update, :index, :search] do
    collection do
      get :search
    end
  end
  
  resources :scraps, only: [:create, :destroy]
end
