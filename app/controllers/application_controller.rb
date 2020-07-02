class ApplicationController < ActionController::API
  include Pundit
  after_action :verify_authorized

  def current_user
    User.find_by(id: params[:user_id])
  end

  def is_logged_in?
    current_user.present?
  end
end
