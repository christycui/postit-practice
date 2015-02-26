class UsersController < ApplicationController
  before_action :set_user, only: [:update, :edit, :show]
  def show
    @user = User.find(params[:id])
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
end