class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(permitted_params(:product))
    if @product.save
      redirect_to product_url
    else
      render action: 'new'
    end
  end
end
