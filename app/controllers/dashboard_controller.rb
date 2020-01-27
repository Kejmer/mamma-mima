class DashboardController < ApplicationController
  skip_before_action :require_user, only: [:home]
  before_action :require_admin, only: [:admin_controller]

  def admin_controller
  end

  def home
  end

end
