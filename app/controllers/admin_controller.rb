class AdminController < ApplicationController

  def index
    redirect_to root_path unless can? :view_adminpanel, ""
    @products = Product.all
    @reviews = Review.all
    @users = User.all
  end
end
