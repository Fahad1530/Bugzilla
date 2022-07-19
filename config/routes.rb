# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :projects do
    get :project_access, :remove_project_user, :all_users, on: :member
  end

  resources :projects do
    resources :bugs
  end

  get 'home/about'
  root to: 'projects#index'
end
