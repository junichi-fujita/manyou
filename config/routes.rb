Rails.application.routes.draw do
  resources :labels, only: %i[new create destroy]
  namespace :admin do
    root "users#index"
    resources :users, except: [:index, :show]
  end
  root to: "tasks#index"
  resources :tasks, except: :index do
    get "search", on: :collection
    get "label_search", on: :collection
  end
  resources :users, only: [:new, :show, :create]
  resource :session, only: [:create, :destroy]
end
