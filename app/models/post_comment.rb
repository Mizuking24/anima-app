class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :anime, optional: true
  
  validates :comment, presence: true
end
