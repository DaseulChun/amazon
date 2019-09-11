class ProductsController < ApplicationController
  
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @product = Product.new
    render :new
  end

  def create
    @product = Product.new product_params
    @product.user = current_user

    if @product.save
      flash[:notice] = "Product created successfully"
      redirect_to product_item_path(@product)
    else
      render :new
    end

  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = @product.reviews.order(created_at: :desc)
  end

  def index
    @products = Product.all
  end

  def destroy
    flash[:notice] = "Question destroyed!"
    @product.destroy
    redirect_to products_path
  end

  def edit
  end

  def update
    #for user to update the existing question, they must edit and then save it
  
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end


  private

  def product_params
    #params.require(:question): we must have a question object on the params of this request
    params.require(:product).permit(:title, :description, :price)
  end

  def find_product
    #this will get the current value inside of the db
    @product = Product.find params[:id]
  end

end
