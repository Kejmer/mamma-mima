Rails.application.routes.draw do
  root 'dashboard#home', as: 'home'

  # match "/test", :to => "test#index", :via => :get
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :products

  resources :departments

  resources :pizzas

  resources :orders do
    member do
      post :accept
      post :finalize
      post :reject
      post :deliver
    end
  end


  match '/products/department/:dept_id', :to => 'products#warehouse', :via => :get, as: 'warehouse'
  match '/products/:id/delivery/:dept_id', :to => 'products#delivery', :via => :post, as: 'delivery'

  get '/login', controller: 'user_sessions', action: 'new', as: 'login'
  post '/login', controller: 'user_sessions', action: 'create'
  match 'logout', :to => 'user_sessions#destroy', :as => 'logout', :via => [:get, :post, :delete]

  get '/admin_panel', controller: 'dashboard', action: 'admin_panel', as: 'admin_panel'

end
