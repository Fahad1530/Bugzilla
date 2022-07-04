class BugPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     if user.manager? || user.developer?
  #       user.projects.all
  #     elsif user.qa?
  #       scope.all
  #     end
  #   end
  # end

  def index?
    user.present? && user.role == 'qa'
  end

  def new?
    user.present? && user.role == 'qa'
  end

  def create?
    new?
  end

  def bug_assign?
    return true if user.present? && user.role == 'developer'
  end
end
