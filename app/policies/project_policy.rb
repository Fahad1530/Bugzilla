# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.manager? || user.developer?
        user.projects.all
      elsif user.qa?
        scope.all
      end
    end
  end

  def index?
    if manager? || developer?
      @projects = current_user.projects.all if current_user

    elsif qa?
      @projects = Project.all
    end
  end

  def show?
    return true if record.manager == user && user.role == 'manager'
  end

  def new?
    user.present? && user.role == 'manager'
  end

  def create?
    new?
  end

  def update?
    return true if record.manager == user && user.role == 'manager'
  end

  def destroy?
    return true if user.present? && user.role == 'manager'
  end

  def all_users?
    return true if user.present? && user.role == 'manager'
  end

  def grant_access?
    return true if user.present? && user.role == 'manager'
  end

  def remove_user?
    return true if user.present? && user.role == 'manager'
  end
end
