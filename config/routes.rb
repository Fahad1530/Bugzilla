# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users

  resources :projects do
    get :add_users, :remove_users, :all_users, on: :member
  end

  resources :projects do
    resources :bugs
  end

  get 'home/about'
  root to: 'projects#index'
end
