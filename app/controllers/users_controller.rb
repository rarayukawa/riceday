class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit, :create]

  def new
  end

  def index
    @user = current_user
    @users = User.all
    @post = Post.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new
    # @following_users = current_user.following_user
    # @follower_users = current_user.follower_user
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "ユーザー情報更新しました！"
    else
      render "edit"
    end
  end

  def following
    # @userがフォローしているユーザー
    @user = User.find(params[:id])
    @users = @user.following
  end

  def followers
    # @userをフォローしているユーザー
    @user = User.find(params[:id])
    @users = @user.followers
  end



  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
