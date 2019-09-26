class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find params[:product_id]
    @review = Review.new review_params
    @review.product = @product
    @review.user = current_user
    
    if @review.save
      ReviewMailer.new_review(@review).deliver_later
      redirect_to product_path(@product),
      notice: 'Review successfully created!'
    else
      @reviews = @product.reviews.order(created_at: :desc)
      render '/products/show'
    end
  end

  def destroy
    @product = Product.find params[:product_id]
    @review = Review.find params[:id]

    if can? :crud, @review
      @review.destroy
      redirect_to product_path(@product), notice: 'Review Deleted'
    else
      head :unauthorized
    end
    
  end
  
  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end
end
