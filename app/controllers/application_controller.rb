class ApplicationController < ActionController::API
  include Pundit
  before_action :authenticate_request
  after_action :verify_authorized

  attr_reader :current_user

  def authenticate_request
    command = AuthorizeApiRequest.call(request.headers)
    unless command.success?
      render json: { error: 'Not authorized' }, status: :unauthorized
      return
    end

    @current_user = command.result
  end
end
