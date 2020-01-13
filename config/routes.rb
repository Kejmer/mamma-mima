Rails.application.routes.draw do
  root 'test#index', as: 'home'

  # match "/test", :to => "test#index", :via => :get
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :product
end
