RSpec.shared_context "logged in" do |type|
  let(:password) { 'hoge' }
  let!(:current_user) do
    if type == :admin
      FactoryBot.create(:admin_user, password: password)
    else
      FactoryBot.create(:regular_user, password: password)
    end
  end
  let(:jwt_token) do
    command = AuthenticateUser.call(name: current_user.name, password: password)
    unless command.success?
      raise command.errors
    end

    command.result
  end

  def auth_headers
    {
      'Authorization' => jwt_token
    }
  end
end
