class ProductsController < ApplicationController

  before_action :set_product, only: [:show, :edit, :update, :destroy, :delivery]

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

  def warehouse
    @department = Department.find(params[:dept_id])
    @products = Availability.where(department_id: @department.id)
    render :warehouse
  end

  def delivery
    # @department = Department.find(params[:dept_id])
    return if params[:quantity] == 0
    @product.deliver(params[:dept_id], params[:quantity].to_i)
    redirect_to action: "warehouse", dept_id: params[:dept_id]
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
