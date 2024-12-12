class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  rescue_from ActionController::ParameterMissing, with: :handle_missing_params

  private

  def handle_record_not_found(exception)
    render json: {
      status: :not_found,
      error: 'Record not found',
      message: exception.message
    }, status: :not_found
  end

  def handle_record_invalid(exception)
    render json: {
      status: :unprocessable_entity,
      error: 'Validation failed',
      errors: exception.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  def handle_missing_params(exception)
    render json: {
      status: :bad_request,
      error: 'Missing required parameters',
      message: exception.message
    }, status: :bad_request
  end

end
