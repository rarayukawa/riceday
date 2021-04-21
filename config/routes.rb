Rails.application.routes.draw do
  get 'search/search'
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'get_category/children', to: 'posts#get_category_children', defaults: { format: 'json' }
  get 'get_category/grandchildren', to: 'posts#get_category_grandchildren', defaults: { format: 'json' }
  get '/search' => 'search#search'
  post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
  delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
  get 'get_category/new', to: 'homes#category_window', defaults: { format: 'json' }
  get 'user/:id/favorite' => 'users#favorite', as: 'user_favorite'

  resources :users do
    member do
      get :following, :followers
    end
    get :favorites, on: :collection
  end
  resources :relationships, only: [:create, :destroy]




  resources :posts do
    resources :post_comments, only: [:create, :destroy, :edit]
      resource :favorites, only: [:create, :destroy]
  end

  resources :categories, except: [:new]

end
