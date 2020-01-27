class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_menager

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(permitted_params(:user))
    @user.active = true
    @user.approved = true
    @user.confirmed = true
    if @user.save
      redirect_to users_url
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(permitted_params(:user))
      redirect_to users_url
    else
      render action: 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
