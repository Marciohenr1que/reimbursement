Rails.application.routes.draw do
  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
}

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :tags
  resources :claims do
  collection do
    get 'filter', to: 'claims#index'
  end

  member do
    patch 'update_claim', to: 'claims#update_claim'
  end
end

end
