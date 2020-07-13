require 'rails_helper'

RSpec.describe AuthenticateUser, type: :command do
  include_context "command"

  subject(:command_call) { described_class.call(params) }
  let(:params) { {} }
  let(:user) { FactoryBot.create(:user, password: "hoge") }

  context "when data is valid" do
    let(:params) {{
      name: user.name,
      password: "hoge"
    }}

    include_examples 'command call successes'

    it "creates jwt token" do
      command = command_call
      expect(command.result).to be_instance_of(String)
    end
  end

  context "when user does not exist" do
    let(:params) {{
      name: "hogehoge",
      password: "hoge"
    }}
    include_examples 'command call fails'
  end

  context "when password is invalid" do
    let(:params) {{
      name: user.name,
      password: "kore"
    }}
    include_examples 'command call fails'
  end
end
