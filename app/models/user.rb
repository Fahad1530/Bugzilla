# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  enum role: { developer: 0, manager: 1, qa: 2 }

  has_many :workin_ons,  dependent: :destroy
  has_many :projects, through: :workin_ons, dependent: :destroy
  has_many :bugs,  dependent: :destroy
end
