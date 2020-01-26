class OrdersController < ApplicationController

  before_action :set_order, only: [:show, :edit, :update, :destroy, :accept, :deliver, :finalize, :reject]

  def index
    @orders = Order.order(city: :asc)
  end

  def show
  end

  def new
    @order = Order.new
    @pizzas = Pizza.order(name: :asc)
    10.times {@order.order_positions.build}
  end

  def create
    # byebug
    @order = Order.new(order_params)
    @order.status = 'ordered'
    if @order.save
      redirect_to home_url
    else
      render action: 'new'
    end
  end

  def edit
    @pizzas = Pizza.order(name: :asc)
    (10 - @order.order_positions.size).times {@order.order_positions.build}
  end

  def update
    if @order.update_attributes(order_params)
      redirect_to order
    else
      render action: 'edit'
    end
  end

  def accept
    if @order.final?
      flash[:notice] = "Tego zamówienia nie można już zmienić"
      return false
    end
    @order.status = 'prepared'
    @order.save
  end

  def deliver
    if @order.final?
      flash[:notice] = "Tego zamówienia nie można już zmienić"
      return false
    end
    @order.status = 'delivery'
    @order.save
  end

  def finalize
    if @order.final?
      flash[:notice] = "Tego zamówienia nie można już zmienić"
      return false
    end
    @order.status = 'done'
    @order.save
    @order.department.earnings += @order.price
    @order.department.save
  end

  def reject
    if @order.final?
      flash[:notice] = "Tego zamówienia nie można już zmienić"
      return false
    end

    if @order.status == 'ordered'
      @order.restore_products
    end

    @order.status = 'rejected'
    @order.save
  end

  private

  def set_dept
    @order = Order.find(params[:id])
  end

  def order_params
    param = params.require(:order).permit(:address, :receive_form, :department_id, order_positions_attributes: [ :pizza_id, :amount ])
    param[:order_positions_attributes] = param[:order_positions_attributes].select {|key, pos| pos[:amount].present?}
    param
  end
end
