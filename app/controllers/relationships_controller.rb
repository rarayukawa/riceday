class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:following_id])
    current_user.follow(@user)
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
  end
  
  def follow
    current_user.follow(params[:id])
    redirect_to users_path
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to users_path
  end
end
