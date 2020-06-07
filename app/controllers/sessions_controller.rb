class SessionsController < ApplicationController
  before_action :check_params, only: [:create]
  before_action :signed_in?, only: [:new, :create]

  def new
    @user = User.new
  end

  def create_from_socialmedia
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path, flash: { success: "Signed In successfully!" }
  end

  def create
    user = User.find_by(email: params[:user][:email])
    return redirect_to root_path, flash: { error: "Incorrect email or password, try again." } unless user && user.authenticate(params[:user][:password])

    session[:user_id] = user.id
    redirection_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: { success: "Successfully Logged Out" }
  end

  def check_params
    errors = []
    errors <<  "Please enter Email!" if params[:user][:email].blank?
    errors <<  "Please enter Password!" if params[:user][:password].blank?
    return redirect_to new_session_path, alert: errors.to_sentence if errors.present?
  end

end
