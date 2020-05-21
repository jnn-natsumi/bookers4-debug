Rails.application.routes.draw do
	# ↓コメントアウト
  # get 'relationships/create'
  # get 'relationships/destroy'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#top'
  get 'home/about' => 'homes#about'

  resources :books

  resources :users do# ,only: [:show,:index,:edit,:update]
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
    # on: :memberの意味はメモを参照
  end
end