class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You are logged in.'
      redirect_to root_path
    else
      flash.now[:danger] = 'There is something wrong with your username or password.'
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:primary] = "You're logged out."
    redirect_to root_path
  end
end