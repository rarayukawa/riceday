class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :favorites, dependent: :destroy

  attachment :post_image

  validates :title, presence: true
  validates :text, presence: true


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
end
