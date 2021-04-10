class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    # 投稿に紐づいたコメントを作成
    @post_comment = @post.post_comments.build(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.save
    render :index
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    render :index
  end


  private
  def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id, :user_id)
  end
end
