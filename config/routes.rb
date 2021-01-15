Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "foods#index"

  resources :foods, only: [:index]

  namespace :api do
  	namespace :v1 do
  		resources :foods, defaults: { format: 'json' }
  	end
  end
end
