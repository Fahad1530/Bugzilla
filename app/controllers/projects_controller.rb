# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy all_users grant_access remove_user]
  before_action :authenticate_user!
  before_action :authorize_project, only: %i[all_users show update destroy]
  after_action :authorize_project, only: %i[new create update grant_access remove_user]
  before_action :project_users, only: %i[grant_access remove_user]

  def index
    @projects = policy_scope(Project)
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = Project.create(project_params)
    respond_to do |format|
      if @project.save
        @project.project_users.create(user: current_user)
        format.html { redirect_to projects_url, notice: t(:created) }
      else
        format.html { redirect_to new_project_path, notice: t(:ncreated) }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: t(:updated) }
      else
        format.html { redirect_to new_project_path, notice: t(:ncreated) }
      end
    end
  end

  def destroy
    return unless @project.destroy
      respond_to do |format|
        format.html { redirect_to projects_url, notice: t(:detroyed) }
      end
    end
  end

  def all_users
    @users = @project.users
    @all_users = Project.not_users(@ids)
  end

  def grant_access
    return unless @project.project_users.create(user_id: params[:user_id])

    flash[:success] = 'User Added'
    respond_to do |format|
      format.html { redirect_to all_users_project_path(@project) }
      format.js {}
    end
  end

  def remove_user
    return unless @project_user.delete

    flash[:success] = 'User deleted'
    respond_to do |format|
      format.html { redirect_to all_users_project_path(@project) }
      format.js {}
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
    @ids = @project.users.ids
  end

  def project_params
    params.require(:project).permit(:title, :user_id)
  end

  def project_users
    @project_user = @project.project_users.find_by(user_id: params[:user_id])
  end

  def authorize_project
    authorize @project
  end
end
