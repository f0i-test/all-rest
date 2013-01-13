Allrest::Application.routes.draw do
  
  resources :things, :path => 'allrest'

  # Find        GET      /thing/123
  # Find All    GET      /thing
  # Update      PUT      /thing/123
  # Create      POST     /thing
  # Delete      DELETE   /thing/123
  get    ':thing/:id' => 'rests#find'
  get    ':thing'     => 'rests#find_all'
  put    ':thing/:id' => 'rests#update'
  post   ':thing'     => 'rests#create'
  delete ':thing/:id' => 'rests#delete'

end
