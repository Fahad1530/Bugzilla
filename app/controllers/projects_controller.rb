class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]


  def index
    @projects = current_user.projects.all

  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = current_user.projects.new
  end

  def edit
  end

  def create
    @project = Project.create(project_params)
    respond_to do |format|
      if @project.save
        @project.workin_ons.create(user:current_user)
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
    end
  end

  def correct_user

    @project = current_user.projects.find_by(id: params[:id])
    redirect_to projects_path, notice: "Not Authorized to edit this project " if @project.nil?
  end

  def all_users
    @project = Project.find(params[:project_id])
    @users = @project.users
    @all_users = User.where.not(id: @project.users.ids)

  end


  def add_users
    project = Project.find(params[:id])
    if project.users << User.find(params[:user_id])
      flash[:project] = 'User added successfully'
    else
      flash[:project] = 'User could not be added'
    end
    redirect_to all_users_projects_path(project)
  end






  private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :user_id)
    end
end
