module JwtRest
  module Tokens
    class JwtRest::Tokens::Jwt
      attr_reader :payload, :token

      def initialize(payload: nil, token: nil)
        @payload = payload || {}
        @token = token
      end

      def load_payload
        @payload[:exp] = default_exp unless @payload[:exp]
        @token = JWT.encode(payload, key, 'RS384')
        self
      end

      def load_token
        parts = JWT.decode(token, key.public_key, true, { algorithm: 'RS384' }) rescue nil
        @payload = parts.reduce({}, :merge) if parts
        self
      end

      private

      def key
        JwtRest::Secrets.rsa_private
      end

      def default_exp
        (Time.now + 24 * 3600).to_i
      end
    end
  end
end
