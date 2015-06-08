class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_out_only
    redirect_to home_path if current_user
  end

  def logged_in_only
    if !current_user
      flash[:notice] = "You need to be logged in to access that feature"
      redirect_to landing_path
    end
  end
end
