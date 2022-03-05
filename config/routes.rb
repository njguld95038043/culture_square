Rails.application.routes.draw do
  devise_for  :end_users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: 'public/homes#top'
  get '/about' => 'public/homes#about'
  get '/rakuten_books' => 'public/rakuten_books#search'
  scope module: :public do
    resources :end_users, only: [:edit, :update]
    resources :reviews
  get '/end_users/my_page' => 'end_users#show'
  get "/end_users/unsubscribe" => "end_users#unsubscribe"
  patch "/end_users/withdraw" => "end_users#withdraw"
  end

  namespace :admin do
    resources :genres, only: [:index, :create, :destroy]
    resources :end_users, only: [:index, :show, :edit, :update]
    root to: "homes#top"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
