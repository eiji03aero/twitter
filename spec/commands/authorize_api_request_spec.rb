require 'rails_helper'

RSpec.describe AuthorizeApiRequest, type: :command do
  include_context "command"

  subject(:command_call) { described_class.call(params) }
  let(:params) { {} }
  let!(:user) { FactoryBot.create(:user, password: "hoge") }
  let!(:token) { AuthenticateUser.call(name: user.name, password: "hoge").result }

  context "when data is valid" do
    let(:params) {{
      'Authorization' => token
    }}

    include_examples 'command call successes'

    it "returns user" do
      command = command_call
      expect(command.result.id).to eq user.id
    end
  end

  context "when Authorization header does not exist" do
    let(:params) { {} }
    include_examples 'command call fails'
  end

  context "when token is invalid" do
    let(:params) {{
      'Authorization' => token + 'a'
    }}
    include_examples 'command call fails'
  end
end
