class ProductMailer < ApplicationMailer

  def new_product(product)
    @product = product
    @product_owner = product.user
   
    mail(
      to: @product_owner.email,
      subject: "You've created a new product: #{product.title}"
    )
  end
end
