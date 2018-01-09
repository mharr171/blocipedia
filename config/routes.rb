Rails.application.routes.draw do
  get 'welcome/index'

  get 'welcome/about'

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
