Rails.application.routes.draw do
  get 'wikis/create'

  get 'wikis/update'

  get 'wikis/show'

  get 'wikis/index'

  get 'wikis/new'

  get 'wikis/edit'

  get 'wikis/destroy'

  devise_for :users

  resources :wikis

  get 'welcome/index'

  get 'welcome/about'

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
