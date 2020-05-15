class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :authorize, :signed_in?, :is_admin?, :authenticate_user!, :authenticate_admin!, :redirection_path

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    return redirect_to new_session_path, alert: 'You must be logged in to access this page.' if current_user.nil?
  end

  def signed_in?
    current_user&.present?
  end

  def is_admin?
    current_user&.admin?
  end

  def authenticate_user!
    return redirect_to root_path, flash: {error: "Please sign in or sign up first to proceed with further actions."} unless signed_in?
  end

  def authenticate_admin!
    return redirect_to root_path, flash: {error: "Page can be accessed by Admin only!"} unless is_admin?
  end

  def redirection_path
    if is_admin?
      return redirect_to current_user
    else
      return redirect_to root_path
    end
  end

end