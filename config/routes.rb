Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: :sessions },
                     path_names: { sign_in: :login }

  post 'password/edit', to: 'password#edit'
  post 'password/update', to: 'password#update'

  resources :tweeets
  resources :organizations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
