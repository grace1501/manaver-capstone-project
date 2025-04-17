Rails.application.routes.draw do
  devise_for :users

  unauthenticated do
    root "pages#about"
  end
  
  authenticated :user do
    root "folders#index", as: :authenticated_root
  end

  resources :folders
  
  resources :versions, except: [:index]

  get "versions/:id/make_default", to: "versions#make_default", as: :make_default
  
  get "about", to: "pages#about"
end
