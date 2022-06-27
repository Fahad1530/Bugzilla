class Project < ApplicationRecord
  has_many :workin_ons, dependent: :destroy
  has_many :users, through: :workin_ons, dependent: :destroy
  has_many :project_developers, dependent: :destroy, dependent: :destroy
  has_many :developers, class_name: 'User', through: :project_developers, dependent: :destroy, source: :project
  has_many :project_qas, dependent: :destroy
  has_many :qas, class_name: 'User', through: :project_qas, dependent: :destroy, source: :project
  has_one  :project_manager, dependent: :destroy
  has_many :managers, class_name: 'User', through: :project_manager, dependent: :destroy, source: :project
  has_many :bugs, dependent: :destroy
end
