class UserSessionsController < ApplicationController
  skip_before_action :require_user, only: [:create, :new]

  def new
    @user_session = UserSession.new
    @department = Department.new
  end

  def create
    @user_session = UserSession.new(user_session_params.to_h)
    if @user_session.save
      redirect_to home_url
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to home_url
  end

  def index
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password, :remember_me)
  end
end