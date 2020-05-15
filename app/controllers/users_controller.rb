class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email.downcase!
    if @user.save
      redirect_to root_path, flash: { success: "Account created successfully!" }
    else
      render :new, flash: { error: "Validation error" }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :admin, :email, :phone, :password, :password_confirmation)
  end
end
