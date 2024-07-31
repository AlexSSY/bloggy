class SessionsController < ApplicationController
  def new
    cookies[:referrer] = request.referrer
    @user = User.new
  end
  
  def create
    @user = User.authenticate_by login_params

    if @user.present?
      login @user
      url = cookies[:referrer]
      cookies.delete(:referrer)
      redirect_to url, notice: "you have been logged in successfully."
    else
      flash[:alert] = "incorrect email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to new_session_path, notice: "you have been logged out successfully."
  end

  private
  
    def login_params
      params.require(:user).permit(:email, :password)
    end
end
