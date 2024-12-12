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
        
        get "/tasks", to: "task#index"
        get "/user_tasks", to: "task#user_tasks"
        post "/task/create", to: "task#create_user_task"
        patch "/update_task/:id", to: "task#update_task"
        delete "/task/:id", to: "task#destroy_task"

        # resources :task, only: [:index, :show, :create, :update, :destroy]
      end   

      resources :user, only: [:index, :update, :destroy]
    end
        

  end
  # Defines the root path route ("/")
  # root "posts#index"
end
