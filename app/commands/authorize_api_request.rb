class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private
    attr_reader :headers

    def user
      unless decoded_auth_token
        return
      end

      @user = User.find_by_id(decoded_auth_token[:user_id])
      unless @user
        errors.add(:token, 'Invalid token')
        return
      end

      @user
    end

    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    rescue => e
      errors.add(:token, e.message)
    end

    def http_auth_header
      unless headers['Authorization'].present?
        errors.add(:token, 'Missing token')
        return
      end

      headers['Authorization'].split(' ').last
    end
end
