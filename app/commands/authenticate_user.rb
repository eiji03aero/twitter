class AuthenticateUser
  prepend SimpleCommand

  def initialize(params)
    @name = params[:name]
    @password = params[:password]
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private
    attr_accessor :name, :password

    def user
      user = User.find_by_name(name)
      unless user
        errors.add :user_authentication, 'user not found'
        return
      end

      unless user.authenticate(password)
        errors.add :user_authentication, 'invalid credentials'
        return
      end

      user
    end
end
