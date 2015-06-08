class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Account Created"
      session[:user_id] = @user.id
      redirect_to home_path
    else
      params[:tab] = 'sign-up'
      @for_test_purposes = params[:tab]
      render '/pages/index'
    end
  end

  def show
    @user = User.find(params[:id])
    @title = @user.username.capitalize
  end

  private
  def user_params
    params.require(:user).permit(:username,:email,:password)
  end
end