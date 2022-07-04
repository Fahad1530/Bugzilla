class BugsController < ApplicationController
  before_action :set_project, only: %i[new index create]
  def index
    @bug = @project.bugs.all
    authorize @bug
  end

  def new
    @bug = @project.bugs.build
    authorize @bug
  end

  def create
    @bug = @project.bugs.new(bug_params)
    authorize @bug
    @bug.user = current_user
    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_bugs_path(@project.id), notice: 'bug was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def bug_assign
    # @project = Project.find(params[:project_id])
    @bug = Bug.find(params[:id])
    authorize @bug
    @bug.developer_id = current_user.id
    if @bug.save
      respond_to do |format|
        format.html { redirect_to project_path(@bug.project), notice: 'bug assignment successfully' }
      end
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :description, :bug_type, :deadline, :creator_id, :image)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
