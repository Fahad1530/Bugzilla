# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :manager?, :developer?, :qa?
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:warning] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :role) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :role, :password, :current_password)
    end
  end

  def manager?
    current_user && current_user.role == 'manager'
  end

  def developer?
    current_user && current_user.role == 'developer'
  end

  def qa?
    current_user && current_user.role == 'qa'
  end
end
