Jobber::Application.routes.draw do

  match 'dashboard' => 'dashboard#index'

  root :to => "dashboard#index"

end
