# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bug, type: :model do
  describe 'validations Test' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(5) }
    it { is_expected.to validate_presence_of(:bug_type) }
    it { is_expected.to validate_presence_of(:project_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:project) }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'Upload image' do
    it 'saves the image' do
      file = Rails.root.join('app/assets/images/ava.png')
      image = ActiveStorage::Blob.create_after_upload!(io: File.open(file, 'rb'), filename: 'ava.png').signed_id
      bug = described_class.new(image: image)
      bug.image_type
      expect(bug.errors.messages).to eq({})
    end
  end

  it 'does not save the image' do
    file = Rails.root.join('app/assets/images/my.pdf')
    image = ActiveStorage::Blob.create_after_upload!(io: File.open(file, 'rb'),
                                                     filename: 'my.pdf').signed_id
    bug = described_class.new(image: image)
    bug.image_type
    expect(bug.errors.messages).not_to be(nil)
  end

  it 'not valid date' do
    deadline = build(:bug, deadline: '2022-06-25')
    deadline.check_date
    expect(deadline.errors.messages).not_to be(nil)
  end
end
