Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_for :users, controllers:{
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  
  post "/custom_sign_up", to: "users/omniauth_callbacks#custom_sign_up"

  authenticated :user do
    root 'home#index'
  end

  unauthenticated :user do
    devise_scope :user do
      root "home#main", as: :unregistered_root
    end
  end
end
