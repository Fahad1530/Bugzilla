require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let(:user) { FactoryBot.create(:user, :manager) }
  let(:project) { FactoryBot.create(:project) }

  before do
    sign_in user
    create(:project_user, user: user, project: project)
  end

  describe 'GET #index' do
    before do
      get projects_path
    end

    it 'index page only if user log in' do
      expect(response).to render_template('projects/index')
    end

    it 'assign project' do
      expect(assigns(:projects)).to match_array([project])
    end

    it 'does not show index page if the user is not logged in' do
      sign_out user
      get projects_path
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'only authorize record will be displayed' do
      expect(assigns(:projects)).to eq([project])
    end

    it 'record will not be shown to not authorized person' do
      project1 = create(:project, title: 'Second Project')
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

  describe 'project#update' do
    it 'project should be updated' do
      put project_path(project.id), params: { project: { title: 'new project' } }
      expect(flash[:notice]).to eq(I18n.t(:updated))
    end

    it 'project should not updated' do
      put project_path(project.id), params: { project: { title: 'n' } }
      expect(response).to redirect_to(new_project_path)
    end
  end

  describe 'project#destroy' do
    it 'project should be deleted' do
      delete project_path(project.id), params: { project: project.title }
      expect(flash[:notice]).to eq(I18n.t(:detroyed))
    end
  end

  describe 'project#all_user' do
    it 'project should be deleted' do
      get all_users_project_path(project.id), params: { project: project.title }
      expect(response).to render_template('projects/all_users')
    end
  end

  describe 'project#grant_access' do
    it 'user should given access' do
      get grant_access_project_path(project.id), params: { project: project.title }
      expect(response).to redirect_to(all_users_project_path)
    end
  end

  describe 'project#remove_user' do
    it 'user should be removed from project' do
      get remove_user_project_path(project.id), params: { project: project.title, user_id: user.id }
      expect(response).to redirect_to(all_users_project_path)
    end
  end
end
