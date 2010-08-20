Jobber::Application.routes.draw do

  get "dashboard" => "dashboard#index"
  get "chat/:id" => "chat#show"
  post "chat/:id" => "chat#create"
  get "documents/current/:id" => "documents#current"

  match "documents/patch/:id" => "documents#patch", :via => [ :get, :post ]
  match "documents/patch/:id.:format" => "documents#patch", :via => [ :get, :post ]

  resources :interviews
  resources :templates
  resources :documents

  root :to => "dashboard#index"

end
