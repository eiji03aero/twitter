require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  before(:each) do
    JSON
  end

  describe "GET /api/v1/users" do
    let(:user) { create(:user) }

    before(:each) do
      allow(User).to receive(:all).and_return([user])
      expect(User).to receive(:all)
      get "/api/v1/users", as: :json
    end

    context "when data is valid" do
      it "returns users" do
        expected = [UserSerializer.new(user)].to_json
        expect(response.body).to eq expected
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /api/v1/users/:id" do
    let(:user) { create(:user) }

    before(:each) do
      allow(User).to receive(:find).and_return(user)
      expect(User).to receive(:find)
      get "/api/v1/users/#{user.id}", as: :json
    end

    context "when data is valid" do
      it "returns user" do
        expected = UserSerializer.new(user).to_json
        expect(response.body).to eq expected
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST /api/v1/users" do
    let(:name) { Faker::Internet.unique.username }
    let(:params) do
      {
        name: name,
        self_introduction: "hoge",
      }
    end

    before(:each) do
      post "/api/v1/users", params: params, as: :json
    end

    context "when data is valid" do
      it "returns user" do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to include params
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when data is invalid" do
      let(:name) { nil }

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "PATCH /api/v1/users/:id" do
    let(:user) { create(:user) }
    let(:params) do
      {
        user: {}
      }
    end

    before(:each) do
      patch "/api/v1/users/#{user.id}", params: params, as: :json
    end

    context "when data is valid" do
      let(:params) do
        {
          user: {
            name: "hoge"
          }
        }
      end

      it "returns updated user" do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to include params[:user]
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE /api/v1/users/:id" do
    let(:user) { create(:user) }

    before(:each) do
      delete "/api/v1/users/#{user.id}", as: :json
    end

    context "when data is valid" do
      it "returns deleted user" do
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result[:id]).to eq user.id
      end
    end
  end
end
