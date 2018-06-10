Rails.application.routes.draw do
  resources :ubs, only: [:index]
end
