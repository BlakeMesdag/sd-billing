SdBilling::Application.routes.draw do
  match '/login', :to => 'sessions#new', :as => :login, via: [:post, :get]
  post '/auth/:provider/callback', :to => 'sessions#create'
  post '/auth/failure', :to => 'sessions#failure'
  get '/logout', :to => 'sessions#destroy', :as => :logout

  scope format: true, constraints: { format: :json } do
    resources :invoices, only: [:index, :show, :update, :create, :destroy]
  end

  match "/*all" => "invoices#index", via: [:get, :post]

  root to: "invoices#index"
end
