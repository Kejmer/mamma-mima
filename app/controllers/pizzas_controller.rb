class PizzasController < ApplicationController

  before_action :set_pizza, only: [:show, :edit, :update, :destroy]

  def index
    @pizzas = Pizza.order(name: :asc)
  end

  def new
    @products = Product.all
    @pizza = Pizza.new
    10.times {@pizza.recipes.build}
  end

  def create
    @pizza = Pizza.new(pizza_params)
    if @pizza.save
      redirect_to pizzas_url
    else
      render action: 'new'
    end
  end

  def edit
    @products = Product.all
    (10 - @pizza.recipes.size).times {@pizza.recipes.build}
  end

  def update
    if @pizza.update_attributes(pizza_params)
      redirect_to pizzas_url
    else
      render action: 'edit'
    end
  end

  def set_pizza
    @pizza = Pizza.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pizza_params
    param = params.require(:pizza).permit(:name, :price, recipes_attributes: [ :product_id, :amount ])
    r_attr = param[:recipes_attributes].select {|key, recipe| recipe[:amount].present? && recipe[:amount].to_i > 0 }
    r_proc = {}
    r_attr.each do |inx, val|
      r_proc[val[:product_id]] ||= 0
      r_proc[val[:product_id]] += val[:amount].to_i
    end

    r_attr = {}
    r_proc.each_with_index do |val, inx|
      r_attr[inx] = {}
      r_attr[inx][:pizza_id] = nil
      r_attr[inx][:product_id] = val[0]
      r_attr[inx][:amount] = val[1]
    end

    param[:recipes_attributes] = r_attr
    param
  end

end