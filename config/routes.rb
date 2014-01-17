ProblemManager::Application.routes.draw do
  devise_for :users, :path => "auth"

  resources :problems
  get 'problems/:id/delete' => 'problems#destroy', :as => :delete_problem
  post 'problems/:id' => 'problems#show'

  resources :statuses
  get 'statuses/:id/delete' => 'statuses#destroy', :as => :delete_status

  resources :subjects
  get 'subjects/:id/delete' => 'subjects#destroy', :as => :delete_subject

  resources :users
  get 'users/:id/delete' => 'users#destroy', :as => :delete_user

  namespace :tasks do
    get 'directioning'
    get 'executing'
  end
  resources :tasks do
    get 'accept'
    get 'decline'
    get 'complete'
    get 'cancel'
  end
  get 'tasks/:id/delete' => 'tasks#destroy', :as => :delete_task

  root :to => 'problems#index'
end
