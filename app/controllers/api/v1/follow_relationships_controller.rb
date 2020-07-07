class Api::V1::FollowRelationshipsController < ApplicationController
  def create
    follow_relationship = FollowRelationship.new(
      follower_id: params[:follower_id],
      followed_id: params[:followed_id],
    )
    authorize follow_relationship
    unless follow_relationship.save
      render json: { errors: follow_relationship.errors }, status: :bad_request
    end

    render json: follow_relationship, status: :created
  end

  def destroy
    follow_relationship = FollowRelationship.find(params[:id])
    authorize follow_relationship
    unless follow_relationship.destroy
      render json: { errors: follow_relationship.errors }, status: :bad_request
    end

    render json: follow_relationship
  end
end
