Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks, except: :index do
    get "search", on: :collection
  end
end
