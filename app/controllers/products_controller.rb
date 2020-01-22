class ProductsController < ApplicationController

  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.order(name: :asc)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(permitted_params(:product))
    if @product.save
      redirect_to products_url
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @product.update_attributes(permitted_params(:product))
      redirect_to products_url
    else
      render action: 'edit'
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
