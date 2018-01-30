Rails.application.routes.draw do
  devise_scope :user do
    root to: "matches#show"
  end

  devise_for :users

  get 'users' => 'users#index'
  get 'users/new' => "users#new", as: :new_user
  get 'users/:id' => 'users#show', as: :user
  post 'users' => "users#create"
  get 'users/:id/edit' => 'users#edit', as: :edit_user
  patch 'users/:id' => "users#update"
  delete 'users/:id' => "users#destroy"

  get 'matches' => 'matches#index'
  get 'matches/new' => "matches#new", as: :new_match
  get 'matches/:id' => 'matches#show', as: :match
  post 'matches' => "matches#create"
  get 'matches/:id/edit' => 'matches#edit', as: :edit_match
  patch 'matches/:id' => "matches#update"
  delete 'matches/:id' => "matches#destroy"

end
