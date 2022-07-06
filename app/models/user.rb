# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  enum role: { developer: 0, manager: 1, qa: 2 }
  validates :name, presence: true, length: { maximum: 50 }

  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users, dependent: :destroy
  has_many :bugs, dependent: :destroy
end
