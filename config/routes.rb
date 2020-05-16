Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: :sessions, passwords: :passwords },
                     path_names: { sign_in: :login }

  resources :tweeets
  resources :organizations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
