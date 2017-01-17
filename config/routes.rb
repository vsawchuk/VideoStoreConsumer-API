Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :customers, only: [:index]

  resources :movies, only: [:index, :show], param: :title

  post "/rentals/:title/check-out", to: "rentals#check_out", as: "check_out"
end
