# frozen_string_literal: true

Rails.application.routes.draw do
  # get '/projects/all_users', to: 'projects#all_users'
  # resources :projects
  resources :projects do
    member do
        get :add_users
        get :remove_users
    end
  end

  devise_for :users
  get 'home/about'
  get ':project_id/all_users', to: 'projects#all_users', as: 'all_users_projects'
  # get ':project_id/:user_id/add_users', to: 'projects#add_users', as: 'add_users_projects'

  root to: 'home#index'
end
