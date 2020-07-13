class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request
  before_action :skip_authorization

  def authenticate
    command = AuthenticateUser.call(params.slice(:name, :password))
    unless command.success?
      render json: { error: command.errors }, status: :unauthorized
      return
    end

    render json: { auth_token: command.result }
  end
end
