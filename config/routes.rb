Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  get "about", to: "about#index"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  get "log_in", to: "session#new"
  post "log_in", to: "session#create" 
  delete "log_out", to: "session#destroy"


  get "new_ledger_all", to: "main#new"
  post "new_ledger_all", to:"main#create"  
  delete "destroy_ledger_all", to:"main#destroy"
  patch "edit_ledger_all",  to:"main#update"
  get "edit_ledger_all",  to:"main#edit"
  
  get "report", to:"report#report_page"
  post "report", to: "report#report_generate"

  get "show_transactions_all", to: "transactions#show"
  post "show_transactions_all", to:"transactions#show_filter"
  get "new_transaction_all", to:"transactions#new"
  post "new_transaction_all", to:"transactions#create"
  get "edit_transaction_all", to:"transactions#edit"
  patch "edit_transaction_all", to:"transactions#update"
  delete "destroy_transaction_all", to:"transactions#destroy"
  delete "delete_document_all", to:"transactions#delete_document"
  patch "approve_transaction_all", to:"transactions#approval"
  patch "reject_transaction_all", to:"transactions#rejection"
  
  get "personal", to:"personal#index"
  get "new_ledger", to: "personal#new"
  post "new_ledger", to:"personal#create"  
  delete "destroy_ledger", to:"personal#destroy"
  patch "edit_ledger",  to:"personal#update"
  get "edit_ledger",  to:"personal#edit"
  
  
  get "show_transactions", to: "personal_transactions#show"
  post "show_transactions", to:"personal_transactions#show_filter"
  get "new_transaction", to:"personal_transactions#new"
  post "new_transaction", to:"personal_transactions#create"
  get "edit_transaction", to:"personal_transactions#edit"
  patch "edit_transaction", to:"personal_transactions#update"
  delete "destroy_transaction", to:"personal_transactions#destroy"
  delete "delete_document", to:"personal_transactions#delete_document"
  patch "approve_transaction", to:"personal_transactions#approval" 
  patch "reject_transaction", to:"personal_transactions#rejection"

  get "all_records", to:"all_records#show"
  post "all_records", to:"all_records#show_filter"

  



  root to: "main#index"
end
