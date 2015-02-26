class UsersController < ApplicationController
  before_action :set_user, only: [:update, :edit, :show]
  before_action :require_same_user, only: [:edit, :update]
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account is created."
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = 'Profile updated.'
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  private
  def set_user
    @user = User.find_by slug: params[:id]
  end
  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end
  
  def require_same_user
    access_denied unless logged_in? && current_user == @user
  end
end