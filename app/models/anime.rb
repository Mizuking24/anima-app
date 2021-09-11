class Anime < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :image, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
