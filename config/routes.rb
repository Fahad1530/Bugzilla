# frozen_string_literal: true

Rails.application.routes.draw do
  # get '/projects/all_users', to: 'projects#all_users'
  # resources :projects
  resources :projects do
    collection do
      get 'all_users'
    end
  end

  devise_for :users
  get 'home/about'
  root to: 'home#index'

 end

