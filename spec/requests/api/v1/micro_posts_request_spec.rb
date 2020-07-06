require 'rails_helper'

RSpec.describe "Api::V1::MicroPosts", type: :request do
  let!(:current_user) { FactoryBot.create(:user, :admin) }
  let(:request_params) {{
    user_id: current_user.id
  }}
  let!(:micro_posts) { FactoryBot.create_list :micro_post, 2, user: current_user }

  describe "GET /api/v1/micro_posts" do
    it "returns 200" do
      get "/api/v1/micro_posts", params: request_params
      expect(response.status).to eq 200
    end

    it "returns all micro_posts" do
      get "/api/v1/micro_posts", params: request_params
      expect(response_json_body.length).to eq 2
    end
  end

  describe "GET /api/v1/micro_posts/:id" do
    let(:micro_post) { micro_posts.first }

    it "returns 200" do
      get "/api/v1/micro_posts/#{micro_post.id}", params: request_params
      expect(response.status).to eq 200
    end

    it "returns micro_post" do
      get "/api/v1/micro_posts/#{micro_post.id}", params: request_params
      expect(response_json_body["id"]).to eq micro_post.id
    end
  end

  describe "POST /api/v1/micro_posts" do
    it "returns 201" do
      post "/api/v1/micro_posts", params: request_params.merge({ micro_post: FactoryBot.attributes_for(:micro_post, user_id: current_user.id) })
      expect(response.status).to eq 201
    end

    it "creates micro_post" do
      expect do
        post "/api/v1/micro_posts", params: request_params.merge({ micro_post: FactoryBot.attributes_for(:micro_post, user_id: current_user.id) })
      end.to change(MicroPost, :count).by(1)
    end
  end

  describe "PATCH /api/v1/micro_posts/:id" do
    let(:micro_post) { micro_posts.first }

    it "returns 200" do
      patch "/api/v1/micro_posts/#{micro_post.id}", params: request_params.merge({ micro_post: { content: "hoge" } })
      expect(response.status).to eq 200
    end

    it "updates micro_post" do
      expect do
        patch "/api/v1/micro_posts/#{micro_post.id}", params: request_params.merge({ micro_post: { content: "hoge" } })
      end.to change { MicroPost.find(micro_post.id).content }.from(micro_post.content).to("hoge")
    end
  end

  describe "DELETE /api/v1/micro_posts/:id" do
    let!(:micro_post) { FactoryBot.create(:micro_post, user_id: current_user.id) }

    it "returns 200" do
      delete "/api/v1/micro_posts/#{micro_post.id}", params: request_params
      expect(response.status).to eq 200
    end

    it "deletes micro_post" do
      expect do
        delete "/api/v1/micro_posts/#{micro_post.id}", params: request_params
      end.to change(MicroPost, :count).by(-1)
    end
  end
end
