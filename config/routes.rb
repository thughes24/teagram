Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui', as: 'ui_index'

  resources :users, only: [:new,:create,:edit,:update,:show]
  get '/', to: 'pages#index', as: "landing"
  post '/log-in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :images, except: :index do
    resources :comments, only: :create
  end
  get '/home', to: 'images#index', as: 'home'
  get '/search', to: 'images#search', as: 'search'
  get '/upload-1', to: 'images#upload_1', as: 'upload_1'
  get '/explore', to: 'images#explore', as: 'explore'
  post '/like/:id', to: 'likes#create', as: 'like'
  resources :follows, only: :create


end
