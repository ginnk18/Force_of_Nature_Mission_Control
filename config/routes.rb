Rails.application.routes.draw do
  root 'users#dashboard'
  # root 'events#new'
  resources :welcome, only: [:index]
  resource :session, only:[:new, :create, :destroy]
  resources :users, only: [:new, :create, :update, :edit]

  get('users/dashboard', to:'users#dashboard', as: :user_dashboard_index)

  resources :teams
  resources :events, only: [:index, :new, :show, :create, :edit, :update, :destroy] do
     get('/share', to: 'eventsignup#share', as: :shareevent)
     get('newsignup', to: 'eventsignup#new', as: :neweventsignup)
     post('newsignup', to: 'eventsignup#create')
     delete('/:id', to: 'eventsignup#destroy', as: :removeguest)
  end

  # delete("events/:event_id/:id", to: 'eventsignup#destroy')
  resources :userteams, only:[:destroy, :update, :edit]
  post('newsignup/:id', to: 'eventsignup#modalsignup')
  get('eventscal/:id', to: 'events#translate', as: :eventshow)

  namespace :admin do
    resources :dashboard, only: [:index]
  end
  patch("/admin/upcat/:id", to: 'users#changestatus')
  patch("/admin/contacted/:id", to: 'users#contacted')
  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
end
