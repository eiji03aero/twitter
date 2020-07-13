class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, secret_key_base)[0]
      HashWithIndifferentAccess.new body
    end

    private
      def secret_key_base
        Rails.application.secrets.secret_key_base
      end
  end
end
