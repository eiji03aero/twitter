require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  include_context 'api'

  let(:model_class) { User }
  let!(:users) { FactoryBot.create_list(:user, 2) }

  describe "GET /api/v1/users" do
    subject(:send_request) { get "/api/v1/users", headers: auth_headers }

    context "regular user" do
      include_context 'logged in', :regular

      include_examples 'expects http status code', 200

      it "returns users" do
        send_request
        expect(response.parsed_body.length).to eq User.count
      end
    end

    context "admin user" do
      include_context 'logged in', :admin

      include_examples 'expects http status code', 200

      it "returns users" do
        send_request
        expect(response.parsed_body.length).to eq User.count
      end
    end
  end

  describe "GET /api/v1/users/:id" do
    subject(:send_request) { get "/api/v1/users/#{current_user.id}", headers: auth_headers }
    let(:expected_response) {
      current_user
        .serializable_hash
        .slice('name', 'self_introduction')
    }

    context "regular user" do
      include_context 'logged in', :regular
      include_examples 'expects http status code', 200
      include_examples 'expects http response with json'
    end

    context "admin user" do
      include_context 'logged in', :admin
      include_examples 'expects http status code', 200
      include_examples 'expects http response with json'
    end
  end

  describe "POST /api/v1/users" do
    subject(:send_request) { post "/api/v1/users", params: params, headers: auth_headers }
    let(:valid_params) {{ user: FactoryBot.attributes_for(:user) }}
    let(:invalid_params) {{ user: FactoryBot.attributes_for(:user, name: nil) }}
    let(:params) { valid_params }
    let(:expected_response) {
      params[:user]
        .slice('name', 'self_introduction')
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

  describe "PATCH /api/v1/users/:id" do
    subject(:send_request) { patch "/api/v1/users/#{current_user.id}", params: params, headers: auth_headers }
    let(:valid_params) {{ user: FactoryBot.attributes_for(:user) }}
    let(:invalid_params) {{ user: FactoryBot.attributes_for(:user, name: nil) }}
    let(:params) { valid_params }
    let(:expected_response) {
      params[:user]
        .slice('name', 'self_introduction')
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

  describe "DELETE /api/v1/users/:id" do
    subject(:send_request) { delete "/api/v1/users/#{current_user.id}", headers: auth_headers }

    context "regular user" do
      include_context 'logged in', :regular
      include_examples 'expects http status code', 200
      include_examples 'deletes record'
    end

    context "admin user" do
      include_context 'logged in', :admin
      include_examples 'expects http status code', 200
      include_examples 'deletes record'
    end
  end
end
