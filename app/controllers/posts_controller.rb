class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user, only: [:edit, :destroy, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # @user = current_user
    @post.user_id = current_user.id
    if @post.save
      @posts = Post.order(created_at: :desc).limit(8)
      PostCategory.maltilevel_category_create(
      @post,
      params[:parent_id],
      params[:children_id],
      params[:grandchildren_id]
    )
      redirect_to post_path(@post), notice: "投稿しました！"
    else
      @posts = Post.all
      @category_parent_array = Category.category_parent_array_create
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
    @posts = Post.order(created_at: :desc).limit(8)
    @post = Post.new
    @category_parent_array = Category.category_parent_array_create
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

  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:children_id]).children
  end


  private
  def post_params
    params.require(:post).permit(:title, :text, :post_image, { category_ids: [] })
  end
end
