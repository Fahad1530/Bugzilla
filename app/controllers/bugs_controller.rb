class BugsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.build
  end

  def create
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.new(bug_params)
    @bug.user = current_user
    @bug.save
    redirect_to projects_path
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :description, :bug_type, :deadline, :creator_id)
  end
end
