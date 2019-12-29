Rails.application.routes.draw do

  #get 'sessions/new'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help', as: 'help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/new', to: 'users#new' #注册
  get '/login', to: 'sessions#new' #登录
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  #get '/mine',  to: 'users#mine' #个人页面

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :weibos, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  resources :talks do
    member do
      get :talking, :talked
    end
  end

end
