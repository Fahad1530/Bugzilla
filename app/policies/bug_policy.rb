# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  def index?
    @project_id = record.map(&:project_id)
    return true if (user.projects.find_by(id: @project_id) && user.role == 'developer') || user.role == 'qa'
  end

  def new?
    user.present? && user.role == 'qa'
  end

  def create?
    new?
  end

  def update?
    return true if user.role == 'developer'
  end
end
