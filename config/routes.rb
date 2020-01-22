Rails.application.routes.draw do
  root 'dashboard#admin_panel', as: 'home'

  # match "/test", :to => "test#index", :via => :get
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :products

  resources :departments


end
