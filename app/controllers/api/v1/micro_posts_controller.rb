class Api::V1::MicroPostsController < ApplicationController
  skip_before_action :authenticate_request,
    only: [:index, :create, :show]

  def index
    authorize MicroPost
    micro_posts = MicroPost.all
    render json: micro_posts, each_serializer: MicroPostSerializer
  end

  def show
    micro_post = MicroPost.find(params[:id])
    authorize micro_post
    render json: micro_post
  end

  def create
    authorize MicroPost
    micro_post = MicroPost.new(micro_post_params)
    unless micro_post.save
      render json: { errors: micro_post.errors }, status: :bad_request
      return
    end

    render json: micro_post, status: :created
  end

  def update
    micro_post = MicroPost.find(params[:id])
    authorize micro_post
    unless micro_post.update(micro_post_params)
      render json: { errors: micro_post.errors }, status: :bad_request
      return
    end

    render json: micro_post
  end

  def destroy
    micro_post = MicroPost.find(params[:id])
    authorize micro_post
    unless micro_post.destroy
      render json: { errors: user.errors }, status: :bad_request
      return
    end

    render json: micro_post
  end

  private
    def micro_post_params
      params.require(:micro_post).permit(:content, :user_id)
    end
end
