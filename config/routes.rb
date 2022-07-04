# frozen_string_literal: true

Rails.application.routes.draw do
  # get '/projects/all_users', to: 'projects#all_users'
  # resources :projects
  resources :projects do
    member do
      get :add_users
      get :remove_users
      get :all_users
    end
  end

  resources :projects do
    resources :bugs do
      member do
        get :bug_assign
      end
    end
  end

  devise_for :users
  get 'home/about'
  root to: 'projects#index'

  # get ':project_id/all_users', to: 'projects#all_users', as: 'all_users_projects'
  # get ':project_id/:user_id/add_users', to: 'projects#add_users', as: 'add_users_projects'
end
