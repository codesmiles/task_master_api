Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    namespace :v1 do
      namespace :auth do
        post '/signup', to: 'auth#signup'
        post '/login', to: 'auth#login'
        get '/profile', to: 'auth#profile' # show single user
        
        get "/tasks/all", to: "tasks#all"
        resources :tasks do
          # Additional collection routes
          get :completed, on: :collection
          get :pending, on: :collection
          get :overdue, on: :collection
        end

      end   

      resources :user, only: [:index, :update, :destroy]
    end
        

  end
  # Defines the root path route ("/")
  # root "posts#index"
end
