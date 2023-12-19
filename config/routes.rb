Rails.application.routes.draw do

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # 管理者用
  namespace :admin do
    root to: 'homes#top'
    resources :skinitems
    resources :posts, only: [:index, :show]
    resources :users, only: [:index, :show, :edit, :update]
  end

  # 顧客用
  scope module: :public do
  root to:  'homes#top'
  get 'about' => 'homes#about'
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    collection do
    get 'check' => 'users#check'
    patch 'withdraw' => 'users#withdraw'
    end
  end
  resources :skinitems, only: [:index, :show]
  get "search" => "searches#search"
  end
end