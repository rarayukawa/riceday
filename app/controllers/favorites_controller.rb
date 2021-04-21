class FavoritesController < ApplicationController
  before_action :post_params

  def create
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, post_id: @post.id).destroy
  end

  private
  def post_params
    @post = Post.find(params[:post_id])
  end
end
