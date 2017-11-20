Rails.application.routes.draw do
  root 'welcome#index'
  # root 'events#new'
  resources :welcome, only: [:index]
  resource :session, only:[:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :teams
  resources :events, only: [:index, :new, :show, :create, :edit, :update, :destroy] do
     get('newsignup', to: 'eventsignup#new', as: :neweventsignup)
     post('newsignup', to: 'eventsignup#create')
  end
  resources :userteams, only:[:destroy, :update, :edit]
  post('newsignup/:id', to: 'eventsignup#modalsignup')
  get('eventscal/:id', to: 'events#translate', as: :eventshow)

  namespace :admin do
    resources :dashboard, only: [:index]
  end

  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]

end
