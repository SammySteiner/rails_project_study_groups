Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'sessions#index'
  #sessions
  get '/signin', to: 'sessions#new', as: 'signin'
  post '/sessions', to: 'sessions#create'
  post '/signout', to: 'sessions#destroy', as: 'signout'
  get '/signout', to: 'sessions#destroy'

  #users
  get '/users/new', to: 'users#new', as: 'signup'
  post '/users', to: 'users#create'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  patch '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#delete'

  #groups
  get '/groups', to: 'groups#index'
  get '/groups/new', to: 'groups#new', as: 'new_group'
  post '/groups', to: 'groups#create'
  get '/groups/:id', to: 'groups#show', as: 'group'
  get '/groups/:id/edit', to: 'groups#edit', as: 'edit_group'
  patch '/groups/:id', to: 'groups#update'
  delete '/groups/:id', to: 'groups#delete'


  #attendances
  post '/groups/:id/attendances', to: 'attendances#create', as: 'attendances'
  delete '/groups/:id/attendances', to: 'attendances#delete'
  # delete 'groups/:id/attendances', to 'attendances#delete'

  #Notes
  post '/notes', to: 'notes#create'

  #see nested routes



end
