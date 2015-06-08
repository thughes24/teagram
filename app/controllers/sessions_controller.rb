class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged In Successfully!"
      redirect_to home_path
    else
      flash[:notice] = "Invalid Username/Password"
      redirect_to landing_path(tab: "log-in")
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to landing_path
  end
end