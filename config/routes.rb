Rails.application.routes.draw do
  get 'item/index'
  get 'item/new'
  devise_for :users
  root to: "items#index"
  resources :items, only: [:new, :create, :show, :edit, :update, :destroy] do
  end
  resources :users, only: :show
end
