Jobber::Application.routes.draw do

  get "dashboard" => "dashboard#index"
  get "chat/:id" => "chat#show"
  post "chat/:id" => "chat#create"

  resources :interviews
  resources :templates

  root :to => "dashboard#index"

end
