# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resource :user
  resolve('User') { [:user] }

  resources :sessions, only: %i[new create index destroy] do
    delete '', action: :destroy, as: 'logout', on: :collection
  end

  # Defines the root path route ("/")
  root 'home#index'
end
