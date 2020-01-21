class ProductsController < ApplicationController
  def index
    @products = Products.all
  end

  def show
  end

  def new
    @product = Prodcuct.new
  end

  def create
    @product = Prodcuct.new(permitted_params(:product))
    if @product.save
      redirect_to product_url
    else
      render action: 'new'
    end
  end
end
