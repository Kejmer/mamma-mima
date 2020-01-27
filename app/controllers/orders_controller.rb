class OrdersController < ApplicationController

  before_action :set_order, only: [:show, :edit, :update, :destroy, :accept, :deliver, :finalize, :reject]

  def index
    @orders = Order.active
    unless admin?
      @orders = @orders.where(department_id: current_user.department_id) unless admin?
    end
    @orders = @orders.order(created_at: :asc)
  end

  def show
  end

  def new
    @order = Order.new
    @pizzas = Pizza.order(name: :asc)
    10.times {@order.order_positions.build}
  end

  def create
    @order = Order.new(order_params)
    @order.status = 'ordered'
    if @order.save
      redirect_to home_url
    else
      redirect_to new_order_url
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
      redirect_to edit_order_url
    end
  end

  def accept
    if @order.final?
      flash[:notice] = "Tego zamówienia nie można już zmienić"
      return false
    end
    @order.update_column(:status, 'prepared')
    redirect_to order_path(@order.id)
  end

  def deliver
    if @order.final?
      flash[:notice] = "Tego zamówienia nie można już zmienić"
      return false
    end
    @order.update_column(:status, 'delivery')
    redirect_to order_path(@order.id)
  end

  def finalize
    if @order.final?
      flash[:notice] = "Tego zamówienia nie można już zmienić"
      return false
    end
    @order.update_column(:status, 'done')
    @order.department.profits += @order.price
    @order.department.save
    redirect_to orders_path
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
    redirect_to orders_path
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    param = params.require(:order).permit(:address, :receive_form, :department_id, order_positions_attributes: [ :pizza_id, :amount ])
    param[:order_positions_attributes] = param[:order_positions_attributes].select {|key, pos| pos[:amount].present?}
    param
  end
end
