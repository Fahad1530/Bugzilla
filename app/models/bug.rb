class Bug < ApplicationRecord
  belongs_to :user, foreign_key: 'creator_id'
  belongs_to :project
  enum status: { fresh: 0, started: 1, completed: 2 }
  enum bug_type: { feature: 0, bug_type: 1 }
  has_one_attached :image
  validate :check_date, :image_type
  validates :title, presence: true, length: { in: 15..30 }
  validates :title, :bug_type, :project_id, :deadline, :image, presence: true

  def check_date
    errors.add(:deadline, 'enter today or later date') if !deadline.nil? && (deadline < Date.today)
    errors.add(:image, 'is missing!') if image.attached? == false
  end

  def image_type
    if image.attached? && !image.content_type.in?(%('image/jpg image/png'))
      errors.add(:image, 'needs to be a jpg or png!')
    end
  end
end
