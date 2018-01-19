Rails.application.routes.draw do
  get 'wikis/create'

  get 'wikis/update'

  get 'wikis/show'

  get 'wikis/index'

  get 'wikis/new'

  get 'wikis/edit'

  get 'wikis/destroy'

  devise_for :users
  resources :users
  # resources :users, except: [:new]

  resources :wikis

  get 'welcome/index'

  get 'welcome/about'

  post "/users/:id/standard" => "users#make_standard", as: "make_user_standard"
  post "/users/:id/premium" => "users#make_premium", as: "make_user_premium"
  post "/users/:id/admin" => "users#make_admin", as: "make_user_admin"

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
