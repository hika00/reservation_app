Rails.application.routes.draw do
  root "homes#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resource :users, only: [:show] do
    collection do
      get "account"
      get "account/edit"
      patch "account"
      
      get "profile", to: "users#profile"
      get "profile/edit", to: "users#edit_profile"
      patch "profile", to: "users#update_profile"
    end
  end

  resources :rooms do
    collection do
      get "search"
    end
    
    resources :reservations, only: [:new, :create] do
      collection do
        post :confirm
      end
    end
  end

  resources :reservations, only: [:index]

end
