# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def about; end

  def home
    if user_signed_in?
     user_home
    else
     # Unknown user type? Render error or use a default.
    end
  end


protected
  def user_home
    # ...
    render(:template => 'projects_index')
  end
end
