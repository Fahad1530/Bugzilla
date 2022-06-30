# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  enum role: { developer: 0, manager: 1, qa: 2 }
  validates :name, presence: true

  has_many :workin_ons, dependent: :destroy
  has_many :projects, through: :workin_ons, dependent: :destroy
  has_many :bugs, dependent: :destroy
end
