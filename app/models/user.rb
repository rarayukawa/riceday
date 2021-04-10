class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 50, minimum: 1}
  # unipueness: true

  #既にいいねしているかどうか
 def already_favorited?(post)
   self.favorites.exists?(post_id: post.id)
 end

  #フォローしているかを確認
  def following?(user_id)
    following_relationships.find_by(following_id: user.id)
  end

  #フォローする
  def follow(user_id)
    following_relationships.create!(following_id: user.id)
  end

  #フォローを外す
  def unfollow(user_id)
    following_relationships.find_by(following_id: user.id).destroy
  end


end
