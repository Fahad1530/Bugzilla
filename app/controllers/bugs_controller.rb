# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_project, only: %i[new index create]
  after_action :authorize_bug, only: %i[index new create update]
  before_action :set_bug, only: %i[update]
  before_action :developer_to_bug, only: %i[update]

  def index
    @bug = @project.bugs
  end

  def new
    @bug = @project.bugs.build
  end

  def create
    @bug = @project.bugs.new(bug_params)
    @bug.user = current_user
    if @bug.save
      respond_to do |format|
        format.html { redirect_to project_bugs_path(@project.id), notice: t(:bugcreated) }
      end
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  def update
    if @bug.save
      respond_to do |format|
        format.html { redirect_to project_bugs_path, notice: t(:bugupdated) }
      end
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :description, :bug_type, :deadline, :image)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def authorize_bug
    authorize @bug
  end

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def developer_to_bug
    @bug.developer_id = current_user.id
  end
end
