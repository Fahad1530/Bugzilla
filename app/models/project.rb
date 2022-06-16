class Project < ApplicationRecord
  has_many :workin_ons
  has_many :users, through: :workin_ons

end
