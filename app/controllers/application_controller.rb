class ApplicationController < ActionController::Base
  def default_unpermitted_params
    [:id, :created_at, :updated_at]
  end

  def permitted_params(model, options = {})
    unpermitted_params = options[:unpermitted_params] || default_unpermitted_params

    begin
      model_params = params.require(model).except(*unpermitted_params)
      model_class = options[:model_class] || Object.const_get(model.to_s.camelcase)
    rescue Exception => e
      raise "zly model w kontrolerze: #{model}, blad: #{e}"
    end

    model_params.permit!
    model_params
  end

  helper_method :current_user_session, :current_user

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  protected

  def handle_unverified_request
    # raise an exception
    fail ActionController::InvalidAuthenticityToken
    # or destroy session, redirect
    if current_user_session
      current_user_session.destroy
    end
    redirect_to root_url
  end

end
