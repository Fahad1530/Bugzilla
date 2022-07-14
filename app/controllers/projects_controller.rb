# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy all_users]
  before_action :authenticate_user!

  def index
    @projects = policy_scope(Project)
  end

  def show
    authorize @project
  end

  def new
    @project = current_user.projects.new
    authorize @project
  end

  def edit;
  end

  def create
    @project = Project.create(project_params)
    authorize @project
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
    authorize @project
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

  def all_users
    authorize @project
    @users = @project.users
    @all_users = User.where.not(id: @project.users.ids)
  end

  def add_users
    @project = Project.find(params[:id])
    authorize @project
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
    authorize @project
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
end
