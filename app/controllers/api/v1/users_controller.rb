class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users, each_serializer: UserSerializer
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(user_params)
    unless user.save
      render json: { errors: user.errors }, status: :bad_request
      return
    end

    render json: user
  end

  def update
    user = User.find(params[:id])
    unless user.update(user_params)
      render json: { errors: user.errors }, status: :bad_request
      return
    end

    render json: user
  end

  def destroy
    user = User.find(params[:id])
    unless user.destroy
      render json: { errors: user.errors }, status: :bad_request
      return
    end

    render json: user
  end

  private
    def user_params
      params.require(:user).permit(:name, :self_introduction)
    end
end
