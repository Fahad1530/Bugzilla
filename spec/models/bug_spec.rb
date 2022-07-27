require 'rails_helper'

RSpec.describe Bug, type: :model do
  let(:bug) { FactoryBot.build(:bug) }

  describe 'validations Test' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:project_users).dependent(:destroy) }
    it { is_expected.to have_many(:bugs).dependent(:destroy) }
    it { is_expected.to have_many(:projects).through(:project_users).dependent(:destroy) }
  end
end
