class CommentsController < ApplicationController
  before_action :require_user
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user = current_user
    
    if @comment.save
      flash[:success] = 'Your comment is added.'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end