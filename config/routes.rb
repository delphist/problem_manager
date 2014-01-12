ProblemManager::Application.routes.draw do
  devise_for :users

  resources :problems
  get 'problems/:id/delete' => 'problems#destroy', :as => :delete_problem

  resources :statuses
  get 'statuses/:id/delete' => 'statuses#destroy', :as => :delete_status

  resources :subjects
  get 'subjects/:id/delete' => 'subjects#destroy', :as => :delete_subject

  resources :users
  get 'users/:id/delete' => 'users#destroy', :as => :delete_user

  resources :tasks
  get 'tasks/:id/delete' => 'tasks#destroy', :as => :delete_task

  root :to => 'problems#index'
end
