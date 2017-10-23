Rails.application.routes.draw do
root :to => "home#index"
  get 'home/index'
root :to => "home#registration"
  get 'home/registration'
root :to => "home#dashboard"
  get 'home/dashboard'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
