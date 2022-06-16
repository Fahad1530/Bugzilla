# frozen_string_literal: true

Rails.application.routes.draw do
  
  resources :projects
  devise_for :users
  get 'home/about'
  root to: 'home#index'
end
