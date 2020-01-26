class OrdersController < ApplicationController

  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.order(city: :asc)
  end

  def show
  end

  def new
    @order = order.new
  end

  def create
    @order = Order.new(permitted_params(:order))
    if @order.save
      redirect_to home_url
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @order.update_attributes(permitted_params(:order))
      redirect_to order
    else
      render action: 'edit'
    end
  end

  private

  def set_dept
    @order = Order.find(params[:id])
  end
end
