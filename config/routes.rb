Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: :sessions },
                     path_names: { sign_in: :login }

  put 'password/edit', to: 'passwords#edit'
  put 'password/update', to: 'passwords#update'

  resources :tweeets
  resources :organizations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
