class DepartmentsController < ApplicationController

  before_action :set_dept, only: [:show, :edit, :update, :destroy]

  def index
    @departments = Department.order(city: :asc)
  end

  def show
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(permitted_params(:department))
    if @department.save
      redirect_to departments_url
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @department.update_attributes(permitted_params(:department))
      redirect_to departments_url
    else
      render action: 'edit'
    end
  end

  private

  def set_dept
    @department = Department.find(params[:id])
  end
end
