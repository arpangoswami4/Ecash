# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'about', to: 'dashboard#about'

  get 'report', to: 'report#report_page'
  get 'report_generate', to: 'report#report_generate'

  resources :users, only: %i[new create] do
    member do
      delete :logout
    end
    collection do
      get :login
      post :authenticate
    end
  end

  concern :extra do
    member do
      delete :delete_document
      patch :approval
      patch :rejection
    end
    collection do
      get :index_filter
    end
  end

  resources :ledgers do
    collection do
      get :all_records, controller: :transactions
      post :all_records_filter, controller: :transactions
    end
    resources :transactions, concerns: :extra
  end

  constraints ->(req) { req.session[:user_id].present? } do
    root to: 'ledgers#index', as: :authenicated_root
  end

  root to: 'dashboard#index'
end
