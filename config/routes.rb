Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users do
    resource :relationships, only: [:crete, :destroy]
  end

  resources :posts do
    resources :post_comments, only: [:create, :destroy, :edit]
  end

end
