Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  get "about", to: "about#index"

  get "all_records", to:"all_records#index"
  post "all_records", to:"all_records#index_filter"

  get "report", to:"report#report_page"
  post "report", to: "report#report_generate"

  resources :registrations, only: [:new,:create]

  resources :sessions, only: [:new,:create,:destroy]
  
  concern :extra do
    member do
      delete :delete_document
      patch :approval
      patch :rejection
    end
    collection do
      post :index_filter
    end
  end

  resources :ledgers do
    resources :transactions, concerns: :extra
  end

  resources :personal_ledgers do
    resources :personal_transactions,concerns: :extra
  end  
  
  root to: "ledgers#index"
end
