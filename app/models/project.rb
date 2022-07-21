# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :project_users,  dependent: :destroy
  has_many :users, through: :project_users, dependent: :destroy
  has_many :project_developers, dependent: :destroy
  has_many :developers, class_name: 'User', through: :project_developers, dependent: :destroy, source: :project
  has_many :project_qas, dependent: :destroy
  has_many :qas, class_name: 'User', through: :project_qas, dependent: :destroy, source: :project
  has_one  :project_manager, dependent: :destroy
  has_one :manager, class_name: 'User', through: :project_manager, dependent: :destroy, source: :project

  has_many :bugs, dependent: :destroy
  validates :title, length: 5..50, uniqueness: true, presence: true

  scope :not_users, ->(ids) { User.where.not(id: ids) }
end
