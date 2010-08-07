Jobber::Application.routes.draw do

  match "dashboard" => "dashboard#index"

  resources :interviews

  match "chat/:id" => "chat#show", :via => :get
  match "chat/:id" => "chat#create", :via => :post

  root :to => "dashboard#index"

end
