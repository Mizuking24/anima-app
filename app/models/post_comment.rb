class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :anime, optional: true
end
