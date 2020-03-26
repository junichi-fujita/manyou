Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks, except: :index do
    get "search", on: :collection
  end
  resources :users, only: [:new, :show, :create]
  resource :session, only: [:create, :destroy]
end
