# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { FactoryBot.build(:project) }

  describe 'validations Test' do
    it { is_expected.to validate_presence_of(:title) }
    it { expect(project).to validate_uniqueness_of(:title).ignoring_case_sensitivity }
    it { is_expected.to validate_length_of(:title).is_at_least(5) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:project_users).dependent(:destroy) }
    it { is_expected.to have_many(:project_developers).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:project_users).dependent(:destroy) }

    it {
      expect(subject).to have_many(:developers).class_name('User').through(:project_developers).dependent(:destroy).source(:project)
    }

    it { is_expected.to have_many(:project_qas).dependent(:destroy) }
    it { is_expected.to have_many(:qas).class_name('User').through(:project_qas).dependent(:destroy).source(:project) }
    it { is_expected.to have_one(:project_manager).dependent(:destroy) }

    it {
      expect(subject).to have_one(:manager).class_name('User').through(:project_manager).dependent(:destroy).source(:project)
    }

    it { is_expected.to have_many(:bugs).dependent(:destroy) }
  end

  describe '#not_users' do
    it 'raises ArgumentError with equal name' do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      project = FactoryBot.create(:project)
      described_class.not_users(user1.id)
      expect(described_class.not_users(user1.id)).not_to include(user1)
    end
  end
end
