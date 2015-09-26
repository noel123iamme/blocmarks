Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show, :update]

  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
