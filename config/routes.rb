Rails.application.routes.draw do
  resource :welcome, only: :show
  resource :sessions, only: [:new, :create, :destroy]

  namespace :account do
    resources :tasks do
      put :start, on: :member
      put :finish, on: :member
    end

    root to: 'tasks#index'
  end

  root to: 'welcome#show'
end
