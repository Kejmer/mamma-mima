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
end
