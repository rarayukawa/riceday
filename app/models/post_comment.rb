class PostComment < ApplicationRecord
  belongs_to :user_params
  belongs_to :post_params
  
  validates :comment, presence: true
end
