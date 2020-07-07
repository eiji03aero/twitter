require 'rails_helper'

RSpec.describe "Api::V1::FollowRelationships", type: :request do
  let!(:current_user) { FactoryBot.create(:user, :admin) }
  let!(:other_user) { FactoryBot.create(:user) }
  let(:request_params) {{
    user_id: current_user.id
  }}

  describe "POST /api/v1/follow_relationships" do
    let(:params) {
      request_params.merge({
        follower_id: current_user.id,
        followed_id: other_user.id,
      })
    }

    it "returns 201" do
      post "/api/v1/follow_relationships", params: params
      expect(response.status).to eq 201
    end

    it "creates relationship" do
      expect {
        post "/api/v1/follow_relationships", params: params
      }.to change(FollowRelationship, :count).by(1)
    end
  end

  describe "DELETE /api/v1/follow_relationships/:id" do
    let!(:relationship) {
      FactoryBot.create(:follow_relationship, follower_id: current_user.id, followed_id: other_user.id)
    }

    it "returns 200" do
      delete "/api/v1/follow_relationships/#{relationship.id}", params: request_params
      expect(response.status).to eq 200
    end

    it "creates relationship" do
      expect {
        delete "/api/v1/follow_relationships/#{relationship.id}", params: request_params
      }.to change(FollowRelationship, :count).by(-1)
    end
  end
end
