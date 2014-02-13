Crdb::Application.routes.draw do
  get "home/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'home#index'
  
  resources :customers do
    resources :projects
  end
  
  resources :projects
  
  get '/projects/:id/status', to: 'projects#status', as: 'project_status'

end
