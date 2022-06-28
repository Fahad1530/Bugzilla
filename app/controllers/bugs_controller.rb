class BugsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.all
  end

  def new
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.build
  end

  def create
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.new(bug_params)
    @bug.user = current_user
    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_url(@project), notice: 'bug was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :description, :bug_type, :deadline, :creator_id, :image)
  end
end