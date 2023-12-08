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

  # 管理者用
  namespace :admin do
    root to: 'homes#top'
    resources :skinitems
    resources :users, only: [:index, :show, :edit, :upate]
    resources :categories
    resources :skinconcerns
  end

  # 顧客用
  scope module: :public do
  root to:  'homes#top'
  get 'about' => 'homes#about'
  resources :posts
  resources :users, only: [:index, :show, :edit, :check, :update]
  resources :skinitems, only: [:index, :show]
  end

end
