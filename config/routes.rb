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

  namespace :admin do
    root to: 'homes#top'
    resources :skinitems, only: [:index, :new, :show, :edit]
  end


  root to:  'public/homes#top'
  get 'about' => 'homes#about'
  resources :posts, only: [:index, :new, :show,:edit]
  resource :users
    
    
end
