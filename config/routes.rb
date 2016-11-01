Rails.application.routes.draw do
  resources :ads
  #Rutas para las ads
  get "/premiun", to: "ads#premiuns"
  get "/top", to: "ads#tops"
  get "/populares", to: "ads#populares"
  get "/nuevos", to: "ads#nuevos"
  get "/usados", to: "ads#usados"
  get "/economicos", to: "ads#economicos"
  get "/caros", to: "ads#caros"
  get "/vendidos", to: "ads#vendidos"
  get "/recientes", to: "ads#index"
  get "/informativo", to: "ads#publicidad"
  get "/encuesta", to: "home#download"

  put "/ads/:id/premiun", to: "ads#premiun"
  put "/ads/:id/top", to: "ads#top"
  put "/ads/:id/sell", to: "ads#sell"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/dashboard", to: "home#dashboard"

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
