require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }
  let(:current_user) { user }
  let(:request_params) {{
    user_id: current_user.id
  }}

  describe "GET /api/v1/users" do
    before(:each) do
      get "/api/v1/users", params: request_params
    end

    context "regular user" do
      let(:current_user) { user }

      it "returns users" do
        expect(JSON.parse(response.body).empty?).to be_falsy
        expect(response).to have_http_status(200)
      end
    end

    context "admin user" do
      let(:current_user) { admin }

      it "returns users" do
        expect(JSON.parse(response.body).empty?).to be_falsy
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /api/v1/users/:id" do
    before(:each) do
      get "/api/v1/users/#{user.id}", params: request_params
    end

    context "regular user" do
      let(:current_user) { user }

      it "returns user" do
        expect(JSON.parse(response.body).empty?).to be_falsy
        expect(response).to have_http_status(200)
      end
    end

    context "admin user" do
      let(:current_user) { admin }

      it "returns users" do
        expect(JSON.parse(response.body).empty?).to be_falsy
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST /api/v1/users" do
    let(:name) { Faker::Internet.unique.username }
    let(:params) {{
      name: name,
      self_introduction: "hoge",
    }}

    before(:each) do
      post "/api/v1/users", params: request_params.merge({user: params})
    end

    context "regular user" do
      let(:current_user) { user }

      context "when data is valid" do
        it "creates user" do
          expect(JSON.parse(response.body, symbolize_names: true)).to include params
          expect(response).to have_http_status(200)
        end
      end

      context "when data is invalid" do
        let(:name) { nil }

        it "returns status code 400" do
          expect(response).to have_http_status(400)
        end
      end
    end

    context "admin user" do
      let(:current_user) { admin }

      context "when data is valid" do
        it "creates user" do
          expect(JSON.parse(response.body, symbolize_names: true)).to include params
          expect(response).to have_http_status(200)
        end
      end

      context "when data is invalid" do
        let(:name) { nil }

        it "returns status code 400" do
          expect(response).to have_http_status(400)
        end
      end
    end
  end

  describe "PATCH /api/v1/users/:id" do
    let(:target_user) { create(:user) }
    let(:params) {{
    }}

    before(:each) do
      patch "/api/v1/users/#{target_user.id}", params: request_params.merge({user: params})
    end

    context "regular user" do
      let(:current_user) { target_user }

      context "when data is valid" do
        let(:params) {{
          name: "hoge"
        }}

        it "returns updated user" do
          expect(JSON.parse(response.body, symbolize_names: true)).to include params
          expect(response).to have_http_status(200)
        end
      end

      context "when data is invalid" do
        let(:params) {{
          name: nil
        }}

        it "returns status code 400" do
          expect(response).to have_http_status(400)
        end
      end
    end
  end

  describe "DELETE /api/v1/users/:id" do
    let(:target_user) { create(:user) }

    before(:each) do
      delete "/api/v1/users/#{target_user.id}", params: request_params, as: :json
    end

    context "regular user" do
      let(:current_user) { target_user }

      it "deletes user" do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:id]).to eq target_user.id
      end
    end

    context "admin user" do
      let(:current_user) { admin }

      it "deletes user" do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:id]).to eq target_user.id
      end
    end
  end
end
