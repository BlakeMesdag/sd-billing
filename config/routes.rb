SdBilling::Application.routes.draw do
  scope format: true, constraints: { format: :json } do
    resources :invoices, only: [:index, :show, :update]
  end

  match "/*all" => "invoices#index", via: [:get, :post]

  root to: "invoices#index"
end
