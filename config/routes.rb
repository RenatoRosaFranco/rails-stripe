# frozen_string_literal: true

Rails.application.routes.draw do

  # API => localhost:3000/api/
  namespace :api do
    namespace :v1 do
      post :orders, to: 'orders#create'
    end
  end
end
