# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy all_users]
  before_action :authenticate_user!
  before_action :authorize_project, only: %i[all_users show destroy]
  after_action :authorize_project, only: %i[new create update add_users remove_users]

  def index
    @projects = policy_scope(Project)
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = Project.create(project_params)
    @project.save
    @project.project_users.create(user: current_user)
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully created.' }
    end
  end

  def update
    authorize @project
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: 'Project was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

  def all_users
    @users = @project.users
    @all_users = User.where.not(id: @project.users.ids)
  end

  def add_users
    @project = Project.find(params[:id])
    @project_user = @project.project_users.find_by(user_id: params[:user_id])
    return unless @project.project_users.create(user_id: params[:user_id])

    flash[:success] = 'User Added'
    respond_to do |format|
      format.html { redirect_to all_users_project_path(@project) }
      format.js {}
    end
  end

  def remove_users
    @project = Project.find(params[:id])
    @project_user = @project.project_users.find_by(user_id: params[:user_id])
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
  end

  def project_params
    params.require(:project).permit(:title, :user_id)
  end

  def authorize_project
    authorize @project
  end
end
