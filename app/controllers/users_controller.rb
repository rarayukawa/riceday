class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit, :create]

  def new
  end

  def index
    @user = current_user
    @users = User.order(created_at: :desc).page(params[:page]).per(5)
    @post = Post.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(3)
    @post = Post.new
    #@post = Post.find(params[:id])
    @following_users = current_user.following
    @follower_users = current_user.followers
    @all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    @my_ranks = @all_ranks.select{ |ranking| @post.user_id == current_user.id }
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "ユーザー情報更新しました！"
    else
      render "edit"
    end
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
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
