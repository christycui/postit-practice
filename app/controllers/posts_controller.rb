class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit]
  def index
    @posts = Post.all
  end
  
  def show
    @comment = Comment.new
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:success] = 'Your post is successfully created.'
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      flash[:success] = 'Your post is updated.'
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end
  
  def vote
    @vote = @post.votes.build(user: current_user, vote: params[:vote])
    respond_to do |format|
      format.html do
        if @vote.save
          flash[:success] = 'Your vote was counted.'
        else
          flash[:danger] = 'You already voted on that.'
        end
        redirect_to :back
      end
      format.js
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :url, :description, :category_ids => [])
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
  
  def require_creator
    access_denied unless logged_in? && current_user == @post.user
  end
  
end