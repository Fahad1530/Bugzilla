# frozen_string_literal: true

Rails.application.routes.draw do

  resources :projects do
    member do
      get :add_users
      get :remove_users
      get :all_users
    end
  end

  resources :projects do
    resources :bugs do
    end
  end

  devise_for :users
  get 'home/about'
  root to: 'projects#index'
end
