Rails.application.routes.draw do
  get 'home', to: "pages#home"

  get 'about', to: "pages#about"
  root "pages#home"
  resources :articles

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

end
