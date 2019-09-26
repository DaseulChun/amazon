class ReviewMailer < ApplicationMailer
  def new_review(review)
    @review = review
    @product = review.product
    @product_owner = @product.user

    mail(
      to: @product_owner.email,
      subject: "#{review.user.first_name} added the review to your product."
    )

  end
end
