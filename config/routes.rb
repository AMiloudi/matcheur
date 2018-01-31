Rails.application.routes.draw do
  devise_scope :user do
    root to: "matches#home"
  end


  devise_for :users
  resources :users, except: [:update,:edit,:destroy]
  resources :matches, except: [:edit,:update,:destroy]

  namespace :api do
    resources :users, except: [:update,:edit,:destroy]
    resources :matches, except: [:edit,:update,:destroy]
  end
end
