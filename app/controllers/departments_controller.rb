class DepartmentsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(permitted_params(:department))
    # byebug
    if @department.save
      redirect_to departments_url
    else
      render action: 'new'
    end
  end
end
