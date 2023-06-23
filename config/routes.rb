Rails.application.routes.draw do
  resources :movies, only: [:index, :create, :update, :destroy]
end
