class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    review = Review.find(params[:review_id])
    like = Like.new(user: current_user, review: review)
    
    if !can?(:like, review)
      redirect_to product_path(product), alert: "can't like your own review"
    elsif like.save
      flash[:success] = "Review Liked"
      redirect_to product_path(product)
    else
      flash[:danger] = like.errors.full_messages.join(", ")
      redirect_to product_path(product)
    end
  end

  def destroy
    # returning the like, the user liked amongst the user's likes
    # using the passed params from the 'Like' button [:id]
    # which is like :id
    # like = [Like id: 8, user_id: 14, review_id: 551]
    like = current_user.likes.find(params[:id])

    # like.review: returning the review WHERE review_id = 551
    # like.review = [Review id: 551, body: "Rhetoric is the art of ruling the minds of men.", rating: 1, product_id: 222, created_at: "2019-09-11 17:26:27", updated_at: "2019-09-11 17:26:27", user_id: 15]
    
    # like.review.product : returning the product WHERE product_id = 222
    # like.review.product = [Product id: 222, title: "Rainbow sherbet", description: "treats allergy symptoms", price: 8077.0, created_at: "2017-10-27 00:00:00", updated_at: "2017-10-27 00:00:00", user_id: 18]
    product = like.review.product

    if can? :destroy, like
      like.destroy
      flash[:success] = "Review unliked"
      redirect_to product_path(product)
    else
      flash[:danger] = "Can't delete like"
      redirect_to product_path(product)
    end
  end
end
