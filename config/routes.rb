Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items, only: [:new, :create, :show, :edit, :update, :destroy] do

    resources :purchases, only: [:create, :index]      # 「購入情報を作る機能」

  end
  resources :users, only: :show
  get 'item/index'
  get 'item/new'
end


