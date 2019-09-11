class ApplicationController < ActionController::Base
  # is available across the app
  
  private

  def user_signed_in?
  # convention : add '?' if that method returns true or false
    current_user.present?
  end
  helper_method :user_signed_in?

  def current_user
    if session[:user_id].present?
      @current_user ||= User.find_by_id(session[:user_id])
      # if don't have a current_user, run the next line
    end
  end
  helper_method :current_user
  # by helper_method, current_user method will be available in all the views

  def authenticate_user!
  # rails convention to have a bang
  # to imply that this method gonna have a side-effect
    unless user_signed_in?
      flash[:danger] = "You must be signed in"
      redirect_to new_session_path 
    end
  end
  helper_method :authenticate_user!

end
