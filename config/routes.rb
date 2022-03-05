Rails.application.routes.draw do
  namespace :public do
    get 'rakuten_books/search'
  end
  namespace :public do
    get 'reviews/new'
    get 'reviews/index'
    get 'reviews/show'
    get 'reviews/edit'
  end
  namespace :public do
    get 'end_users/show'
    get 'end_users/edit'
    get 'end_users/unsubscribe'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :admin do
    get 'end_users/index'
    get 'end_users/show'
    get 'end_users/edit'
  end
  namespace :admin do
    get 'genres/index'
  end
  namespace :admin do
    get '/admin' => "admin/homes#top"
  end
  devise_for  :end_users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
