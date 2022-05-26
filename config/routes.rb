Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  get "about", to: "about#index"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "new_ledger", to: "main#new"
  post "new_ledger", to:"main#create"  
  delete "destroy_ledger", to:"main#destroy"
  patch "edit_ledger",  to:"main#update"
  get "edit_ledger",  to:"main#edit"
  
  get "report", to:"main#report_page"
  post "report", to: "main#report_generate"

  get "show_transactions", to: "transactions#show"
  get "new_transaction", to:"transactions#new"
  post "new_transaction", to:"transactions#create"
  get "edit_transaction", to:"transactions#edit"
  patch "edit_transaction", to:"transactions#update"
  delete "destroy_transaction", to:"transactions#destroy"
  

  get "log_in", to: "session#new"
  post "log_in", to: "session#create"
  
  delete "log_out", to: "session#destroy"

  root to: "main#index"
end
