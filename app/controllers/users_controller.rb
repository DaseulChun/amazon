class UsersController < ApplicationController

  def new
    @user = User.new
    # we need above line, coz we use the @user in the form 'new.html.erb'
  end

  def create
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "User has been saved!"
      redirect_to root_path
    else
      flash[:danger] = "User not saved. Try again!"
      render :new
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
