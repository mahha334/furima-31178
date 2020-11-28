Rails.application.routes.draw do
<<<<<<< Updated upstream
=======
  get 'item/index'
  get 'item/new'
>>>>>>> Stashed changes
  devise_for :users
  root to: "items#index"
  resources :items, only: [:new, :create, :show, :edit, :update, :destroy] do
  end
  resources :users, only: :show
end
