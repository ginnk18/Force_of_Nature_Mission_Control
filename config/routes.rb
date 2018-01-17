Rails.application.routes.draw do
  root 'users#dashboard'
  # root 'events#new'
  resources :welcome, only: [:index]
  resource :session, only:[:new, :create, :destroy]
  resources :users, only: [:new, :create, :update, :edit]

  get('users/dashboard', to:'users#dashboard', as: :user_dashboard_index)

  resources :teams
  resources :events, only: [:index, :new, :show, :create, :edit, :update, :destroy] do
     resources :userevents, only: [:new, :create, :destroy]
     get('/share', to: 'eventsignup#share', as: :shareevent)
     get('newsignup', to: 'eventsignup#new', as: :neweventsignup)
     post('newsignup', to: 'eventsignup#create')
     # post('adminsignup', to: 'eventsignup#adminsignup')
     delete('/:id', to: 'eventsignup#destroy', as: :removeguest)
  end


  # post('adminsignup', to: 'eventsignup#adminsignup')
  resources :userteams, only:[:destroy, :update, :edit]
  post('newsignup/:id', to: 'eventsignup#modalsignup')
  get('eventscal/:id', to: 'events#translate', as: :eventshow)

  namespace :admin do
    get('dashboard/signups', to: 'dashboard#signups', as: :signups)
    get('dashboard/people', to: 'dashboard#people', as: :people)
    get('dashboard/teams', to: 'dashboard#teams', as: :teams)
    get('dashboard/events', to: 'dashboard#events', as: :events)


    resources :dashboard, only: [:index]
  end

  patch("/admin/upcat/:id", to: 'users#changestatus')
  patch("/admin/contacted/:id", to: 'users#contacted')
  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
end
