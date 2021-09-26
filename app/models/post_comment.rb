class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :anime, optional: true

  validates :comment, presence: true, length: { in: 2..100 }
end
