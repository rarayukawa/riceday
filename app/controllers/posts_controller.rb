class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user, only: [:edit, :destroy, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿しました！"
    else
      @posts = Post.all
      render 'index'
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @newpost = Post.new
    @newpost_comment = PostComment.new
    @post_comments = @post.post_comments
  end

  def index
    @posts = Post.all
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
    @user = @post.user
    if @user != current_user
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "変更しました！"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
