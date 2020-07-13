require 'rails_helper'

RSpec.describe "Api::V1::MicroPosts", type: :request do
  include_context 'api'

  let(:model_class) { MicroPost }
  let(:valid_params) {{ micro_post: FactoryBot.attributes_for(:micro_post, user_id: current_user.id) }}
  let(:invalid_params) {{ micro_post: FactoryBot.attributes_for(:micro_post, :invalid, user_id: current_user.id) }}

  describe "GET /api/v1/micro_posts" do
    subject(:send_request) { get "/api/v1/micro_posts", headers: auth_headers }

    context "regular user" do
      include_context 'logged in', :regular

      include_examples 'expects http status code', 200

      it 'returns micro_posts' do
        send_request
        expect(response.parsed_body.length).to eq MicroPost.count
      end
    end

    context "admin user" do
      include_context 'logged in', :admin

      include_examples 'expects http status code', 200

      it 'returns micro_posts' do
        send_request
        expect(response.parsed_body.length).to eq MicroPost.count
      end
    end
  end

  describe "GET /api/v1/micro_posts/:id" do
    subject(:send_request) { get "/api/v1/micro_posts/#{micro_post.id}", headers: auth_headers }
    let(:micro_post) { FactoryBot.create(:micro_post, user_id: current_user.id) }
    let(:expected_response) {
      micro_post
        .serializable_hash
        .slice('content')
    }

    context "regular user" do
      include_context 'logged in', :regular
      include_examples 'expects http response with json'
    end

    context "admin user" do
      include_context 'logged in', :admin
      include_examples 'expects http response with json'
    end
  end

  describe "POST /api/v1/micro_posts" do
    subject(:send_request) { post "/api/v1/micro_posts", params: params, headers: auth_headers }
    let(:expected_response) {
      params[:micro_post]
        .slice('content')
    }

    context "regular user" do
      include_context 'logged in', :regular

      context "when data is valid" do
        let(:params) { valid_params }
        include_examples 'expects http status code', 201
        include_examples 'expects http response with json'
        include_examples 'creates record', 1
      end

      context "when data is invalid" do
        let(:params) { invalid_params }
        include_examples 'expects http status code', 400
      end
    end

    context "admin user" do
      include_context 'logged in', :admin

      context "when data is valid" do
        let(:params) { valid_params }
        include_examples 'expects http status code', 201
        include_examples 'expects http response with json'
        include_examples 'creates record', 1
      end

      context "when data is invalid" do
        let(:params) { invalid_params }
        include_examples 'expects http status code', 400
      end
    end
  end

  describe "PATCH /api/v1/micro_posts/:id" do
    subject(:send_request) { patch "/api/v1/micro_posts/#{micro_post.id}", params: params, headers: auth_headers }
    let(:micro_post) { FactoryBot.create(:micro_post, user_id: current_user.id) }
    let(:expected_response) {
      params[:micro_post]
        .slice('content')
    }

    context "regular user" do
      include_context 'logged in', :regular

      context "when data is valid" do
        let(:params) { valid_params }
        include_examples 'expects http status code', 200
        include_examples 'expects http response with json'
      end

      context "when data is invalid" do
        let(:params) { invalid_params }
        include_examples 'expects http status code', 400
      end
    end

    context "admin user" do
      include_context 'logged in', :admin

      context "when data is valid" do
        let(:params) { valid_params }
        include_examples 'expects http status code', 200
        include_examples 'expects http response with json'
      end

      context "when data is invalid" do
        let(:params) { invalid_params }
        include_examples 'expects http status code', 400
      end
    end
  end

  describe "DELETE /api/v1/micro_posts/:id" do
    subject(:send_request) { delete "/api/v1/micro_posts/#{micro_post.id}", headers: auth_headers }
    let!(:micro_post) { FactoryBot.create(:micro_post, user_id: current_user.id) }

    context "regular user" do
      include_context 'logged in', :regular

      include_examples 'expects http status code', 200
      include_examples 'deletes record', -1
    end

    context "admin user" do
      include_context 'logged in', :admin

      include_examples 'expects http status code', 200
      include_examples 'deletes record', -1
    end
  end
end
