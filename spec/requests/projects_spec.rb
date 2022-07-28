require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let(:user) { FactoryBot.create(:user, :manager) }
  let(:project) { FactoryBot.create(:project) }

  # let(:project_user) { FactoryBot.create(:project_user,) }
  before do
    sign_in user
  end

  describe 'GET #index' do
    # it 'association' do
    #   create(:project_user , user: user , project: project)
    #   byebug
    #   expect(true).to eq(true)
    # end

    it 'allows user to view the list of projects' do
      get projects_path
      expect(response).to render_template('projects/index')
    end

    it 'does not list projects if the user is not logged in' do
      sign_out user
      get projects_path
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'only authorize record will be displayed' do
      create(:project_user, user: user, project: project)
      get projects_path
      expect(assigns(:projects)).to eq([project])
    end

    it 'record will not be shown to not authorized person' do
      project1 = FactoryBot.create(:project, title: 'Second Project')
      get projects_path
      expect(assigns(:projects)).not_to eq([project1])
    end
  end

  describe 'project#new' do
    it 'assigns a new project' do
      get new_project_path
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe 'project#create' do
    it 'creates project' do
      expect { post projects_path, params: { project: { title: ' my project' } } }.to change(Project, :count).by(1)
    end

    it 'does not create project' do
      post projects_path, params: { project: { title: ' m' } }
      expect(response).to redirect_to(new_project_path)
    end
  end

  describe 'project#create' do
    it 'creates project' do
      expect { post projects_path, params: { project: { title: ' my project' } } }.to change(Project, :count).by(1)
    end

    it 'does not create project' do
      post projects_path, params: { project: { title: ' m' } }
      expect(response).to redirect_to(new_project_path)
    end
  end
end
