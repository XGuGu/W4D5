Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :goals, only: [:new]
  end
  resource :session, only: [:destroy, :create, :new]
  resources :goals, only: [:create, :show, :destroy, :edit, :update, :index]
end
