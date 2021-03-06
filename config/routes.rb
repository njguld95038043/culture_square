Rails.application.routes.draw do

  devise_for :end_users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions",
  }

  root to: 'public/homes#top'
  get '/about' => 'public/homes#about'
  get '/rakuten_books' => 'public/rakuten_books#search'
  get "/unsubscribe/end_users/:id" => "public/end_users#unsubscribe", as: 'unsubscribe'
  get 'chat/:id' => 'public/chats#show', as: 'chat'
  get "search" => "public/searches#search"
  patch "end_users/withdraw" => "public/end_users#withdraw"
  post "contacts/new" => "public/contacts#create"
  get "/thanks" => "public/contacts#thanks"

  scope module: :public do
    patch "/end_users/withdraw" => "end_users#withdraw"
    get 'searches/search_result'
    resources :end_users, only: [:edit, :update, :index, :show] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :reviews, except: [:index] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      collection do
        get 'sort_new'
        get 'sort_rate'
      end
    end
    resources :chats, only: [:create]
    resources :notifications, only: [:index, :destroy]
    resources :contacts, only: [:new]
  end

  namespace :admin do
    resources :genres, only: [:index, :create, :destroy]
    resources :end_users, only: [:index, :show, :edit, :update]
    root to: "homes#top"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
