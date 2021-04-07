class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_not_found_response
    render json: { error: "Resource not found" }, status: :not_found
  end
end
