Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/edit'
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'get_category/children', to: 'posts#get_category_children', defaults: { format: 'json' }
  get 'get_category/grandchildren', to: 'posts#get_category_grandchildren', defaults: { format: 'json' }

  get 'users/:user_id/follows' => 'relationships#follows', as: 'follows'
  get 'users/:user_id/followers' => 'relationships#followers', as: 'followers'
  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
  get 'get_category/new', to: 'homes#category_window', defaults: { format: 'json' }

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]




  resources :posts do
    resources :post_comments, only: [:create, :destroy, :edit]
      resource :favorites, only: [:create, :destroy]
  end

  resources :categories, except: [:new, :show]

end
