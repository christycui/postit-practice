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
  
   def vote
     @comment = Comment.find(params[:id])
     vote = @comment.votes.build(user: current_user, vote: params[:vote])
    if vote.save
      flash[:success] = 'Your vote was counted.'
    else
      flash[:danger] = 'You already voted on that.'
    end
    redirect_to :back
  end
end