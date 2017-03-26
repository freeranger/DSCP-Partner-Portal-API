class ApplicationController < ActionController::API
  include Knock::Authenticable
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_not_found_response
    render json: { message: "Not found", code: "not_found" }, status: :not_found
  end

end
