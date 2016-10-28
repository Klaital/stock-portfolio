Rails.application.routes.draw do
  get '/update_positions', to: 'users#update_positions'
  root 'sessions#new'

  get '/about',     to: 'static_pages#about'
  get '/contact',   to: 'static_pages#contact'
  get '/signup',    to: 'users#new'

  get   '/login',     to: 'sessions#new'
  post  '/login',     to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'

  resources :users do
    resources :stock_positions
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
