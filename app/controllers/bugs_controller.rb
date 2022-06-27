class BugsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.create(bug_params)
    redirect_to bug_path(@bug)
  end

  private
  def bug_params
    params.require(:bug).permit(:title, status:, :bug_type, ,  :body)
  end


end
