Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  devise_for :users
  resources :users
  resources :matches
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
