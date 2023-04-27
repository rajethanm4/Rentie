Rails.application.routes.draw do
  use_doorkeeper
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :users  
  devise_for :accounts
  namespace :api do
    namespace :v1 do
      resources :appointments 
    end
  end

  namespace :api do
      resources :properties
    
  end


  namespace :api do
    namespace :v1 do
      resources :comments
    end
  end
  namespace :api do
    namespace :v1 do
      resources :users do
        member do
          get:user_appointment_count
        end
    end
  end
end
  namespace :api do
    namespace :v1 do
      resources :accounts
    end
  end
  namespace :api do
    namespace :v1 do
      resources :properties do
        member do
          get:property_comments
        end
      end    
    end
  end

  
  get 'comments/index'
  get 'comments/show'
  get 'comments/new'
  get 'comments/edit'
  get 'accounts/index'
  get 'accounts/show'
  get 'accounts/new'
  get 'accounts/edit'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/edit'
  get 'appointments/index'
  get 'appointments/show'
  get 'appointments/new'
  get 'appointments/edit'
  get "/dashboard" => 'dashboard#index', as: :dashboard
  resources :appointments
  resources :properties do
    resources :comments
  end 
  resources :accounts do
    resources :comments
  end
  get 'search', to: "properties#search"
  root to: 'public#main'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
