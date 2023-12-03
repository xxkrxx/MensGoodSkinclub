Rails.application.routes.draw do
  
  # 顧客用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
     root to: 'homes#top'
    resources :skinitems, only: [:index, :new, :show, :edit]
  end
  namespace :public do
    root to:  'public/homes#top'
    get 'about' => 'homes#about'
    get 'users/index'
    get 'users/check'
    get 'users/show'
    get 'users/edit'
  end
  namespace :public do
    
    get 'posts/index'
    get 'posts/new'
    get 'posts/show'
    get 'posts/edit'
  end
end
