class ApplicationController < ActionController::API

  include ActionController::Helpers
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # resuce_from ActiveRecord::RecordInvalid, with: :render_not_created_response

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  # def render_not_created_response
  #   render json: { error: exception.message }, status: :not_created
  # end
end
