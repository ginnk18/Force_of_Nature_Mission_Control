Rails.application.routes.draw do
  root 'welcome#index'
  resources :welcome, only: [:index]
  resource :session, only:[:new, :create, :destroy]
  resources :users, only: [:new, :create]
end
