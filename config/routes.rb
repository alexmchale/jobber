Jobber::Application.routes.draw do

  match "dashboard" => "dashboard#index"

  resources :interviews

  root :to => "dashboard#index"

end
