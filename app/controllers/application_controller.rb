class ApplicationController < ActionController::Base
  helper_method :user_logged_in?
  helper_method :current_user
  
  def authenticate_user!
    redirect_to new_session_path, alert: "please log in first" unless user_logged_in?
  end

  def user_logged_in?
    current_user.present?
  end

  def current_user
    User.find_by_id session[:user_id]
  end

  def login user
    reset_session
    session[:user_id] = user.id
  end

  def logout
    reset_session
  end
end
