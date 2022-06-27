class Bug < ApplicationRecord
  belongs_to :user
  belongs_to :project
  enum status: { new: 0, started: 1, completed: 2 }
  enum bug_type: { feature: 0, bug: 1 }
end
