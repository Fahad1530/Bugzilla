# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :projects do
    get :grant_access, :remove_user, :all_users, on: :member

    resources :bugs, only: %i[index new create update]
  end

  root to: 'projects#index'
end
