Rails.application.routes.draw do
  resources :ads
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers:{
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations:"users/registrations"
  }
  
  post "/custom_sign_up", to: "users/omniauth_callbacks#custom_sign_up"

  authenticated :user do
    root "home#index"
  end

  unauthenticated :user do
    devise_scope :user do
      root "home#main", as: :unregistered_root
    end
  end
end
