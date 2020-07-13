require 'rails_helper'

RSpec.describe "Api::V1::Authentication", type: :request do
  include_context 'api'

  describe "POST /api/v1/authentication/authenticate" do
    subject(:send_request) { post "/api/v1/authentication/authenticate", params: params }
    let(:params) { {} }
    let!(:user) { FactoryBot.create(:user, password: "hoge") }

    context "when data is valid" do
      let(:params) {{
        name: user.name,
        password: "hoge"
      }}
      include_examples 'expects http status code', 200
    end

    context "when data is invalid" do
      let(:params) {{
        name: user.name,
        password: "kore"
      }}
      include_examples 'expects http status code', 401
    end
  end
end
