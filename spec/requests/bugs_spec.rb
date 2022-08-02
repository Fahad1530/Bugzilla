require 'rails_helper'

RSpec.describe 'Bugs', type: :request do
  let(:user) { FactoryBot.create(:user, :manager) }
  let(:project) { FactoryBot.create(:project) }

  before do
    sign_in user
  end

  describe 'bugs#index' do
    it 'allows index page to be accessed by valid user' do
      create(:project_user, user: user, project: project)
      developer = create(:user, :developer)
      create(:bug, user: user, project: project, title: 'my testing bug', developer_id: developer.id)
      get project_bugs_path(project.id)
      expect(response).to render_template('bugs/index')
    end
  end

  describe 'bugs#new' do
    it 'assigns a new bug' do
      sign_out user
      user1 = create(:user, :qa)
      sign_in user1

      create(:project_user, user: user1, project: project)

      get new_project_bug_path(project.id)
      expect(assigns(:bug)).to be_a_new(Bug)
    end
  end

  describe 'bug#create' do
    it 'bug created successfully' do
      sign_out user
      user1 = create(:user, :qa)
      sign_in user1

      create(:project_user, user: user1, project: project)
      bug1 = build(:bug)
      expect do
        post project_bugs_path(project.id),
             params: { bug: { title: bug1.title, description: bug1.description, bug_type: bug1.bug_type, deadline: bug1.deadline,
                              image: Rack::Test::UploadedFile.new('app/assets/images/ava.png', 'application/png') } }
      end.to change(Bug, :count).by(1)
    end

    it 'bug is not created' do
      sign_out user
      user1 = create(:user, :qa)
      sign_in user1

      create(:project_user, user: user1, project: project)
      bug1 = build(:bug)
      post project_bugs_path(project.id), params: { bug: { title: bug1.title } }
      expect(response).to redirect_to(new_project_bug_path)
    end
  end

  describe 'bug#update' do
    it 'bug should be updated' do
      sign_out user
      developer = create(:user, :developer)
      sign_in developer
      create(:project_user, user: user, project: project)
      bug1 = create(:bug, user: user, project: project, title: 'my testing bug')
      patch project_bug_path(project.id, bug1.id), params: { project: { title: 'new project' } }
      expect(flash[:notice]).to eq(I18n.t(:bugupdated))
    end
  end
end
