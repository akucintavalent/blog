Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/users/:user_id/posts', to: 'posts#index'
  get '/posts/new', to: 'posts#new'
  post '/posts/create', to: 'posts#create'
  get '/users/:user_id/posts/:id', to: 'posts#show'
  post '/users/:user_id/posts/:id/create_comment', to: 'comments#create'

  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  # Defines the root path route ("/")
  root 'users#index'
end
