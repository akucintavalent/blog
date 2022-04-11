Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/api/login', to: 'authentication#login'
  get '/api/posts', to: 'posts#get_posts'
  get '/api/comments', to: 'comments#get_comments'
  post '/api/comments', to: 'comments#add_comment'

  get '/users/:user_id/posts', to: 'posts#index'
  get '/posts/new', to: 'posts#new'
  post '/posts/create', to: 'posts#create'
  get '/users/:user_id/posts/:id', to: 'posts#show'
  post '/users/:user_id/posts/:id/like', to: 'likes#create'
  post '/users/:user_id/posts/:id/create_comment', to: 'comments#create'
  delete '/comments/delete', to: 'comments#destroy'
  delete '/users/:user_id/posts/:id/delete', to: 'posts#destroy'
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  # Defines the root path route ("/")
  root 'users#index'
end
