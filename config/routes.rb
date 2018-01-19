Rails.application.routes.draw do
  devise_for :users
  resources :users
  # resources :users, except: [:new]

  resources :wikis
  resources :charges, only: [:new, :create]

  get 'welcome/index'

  get 'welcome/about'

  post "/users/:id/self_standard" => "users#make_self_standard", as: "make_self_standard"
  post "/users/:id/self_premium" => "users#make_self_premium", as: "make_self_premium"
  post "/users/:id/self_admin" => "users#make_self_admin", as: "make_self_admin"

  post "/users/:id/other_standard" => "users#make_other_standard", as: "make_other_standard"
  post "/users/:id/other_premium" => "users#make_other_premium", as: "make_other_premium"
  post "/users/:id/other_admin" => "users#make_other_admin", as: "make_other_admin"

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
