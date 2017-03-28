class ApplicationController < ActionController::API
  include Knock::Authenticable
  rescue_from ActionController::ParameterMissing, with: :render_missing_parameter_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_response

  def render_not_found_response
    render json: {errors: { message: "Not found", code: "not_found" }}, status: :not_found
  end

  def render_missing_parameter_response(exception)
    render json: { errors: { full_messages: "#{exception.message}" }}, status: :unprocessable_entity
  end

  def render_invalid_record_response(exception)
    render json: { errors: { message: "#{exception.message}" }}, status: :unprocessable_entity
  end
end
