Rails.application.routes.draw d  namespace :admin do
    root "top#index"
    resources :users, except: [:index, :show]
  end
  root to: "tasks#index"
  resources :tasks, except: :index do
    get "search", on: :collection
  end
  resources :users, only: [:new, :show, :create]
  resource :session, only: [:create, :destroy]
end
