class SessionsController < ApplicationController
  def new
  end
  
  def create
    # byebug
    # debugging environment
    # you can hit 'n' in the console to execute line by line

    user = User.find_by_email params[:email]
    # JS: params = req.body

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged In"
    else
      flash[:alert] = "Wrong email or password"
      redner :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged Out"
  end
  
end
