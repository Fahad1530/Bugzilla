class Project < ApplicationRecord
  has_many :workin_ons, dependent: :destroy
  has_many :users, through: :workin_ons, dependent: :destroy

end
