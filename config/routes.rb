Crdb::Application.routes.draw do
  get "tasks/show"
  get "tasks/index"
  get "tasks/new"
  get "tasks/create"
  get "tasks/edit"
  get "tasks/update"
  get "tasks/destroy"
  get "home/index"
  get "home/today"
  post "home/today"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'home#index'
  
  resources :customers do
    resources :projects
  end
  
  resources :projects do
    resources :tasks
  end
  
  resources :tasks
  
  get '/projects/:id/status', to: 'projects#status', as: 'project_status'

end
