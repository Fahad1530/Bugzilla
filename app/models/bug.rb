class Bug < ApplicationRecord
  belongs_to :user, foreign_key: 'creator_id'
  belongs_to :project
  enum status: { fresh: 0, started: 1, completed: 2 }
  enum bug_type: { feature: 0, bug_type: 1 }
  has_one_attached :image
end
