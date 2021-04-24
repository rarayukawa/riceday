class HomesController < ApplicationController
 #before_action :authenticate_user!
  def top
    @posts = Post.where(user_id: [*current_user.following_ids])
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(4)
  end

  def about
  end

  def mypage
    @following_users = current_user.following_user
    @follower_users = current_user.follower_user
  end

  def category_window
    @children = Category.find(params[:parent_id]).children
  end
end