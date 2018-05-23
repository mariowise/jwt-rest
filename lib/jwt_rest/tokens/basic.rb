module JwtRest
  module Tokens
    class Basic
      attr_reader :username, :password, :token

      def initialize(username: nil, password: nil, token: nil)
        @username = username
        @password = password
        @token = token
      end

      def load_token
        @username, @password = decoder(@token).split(":")
        self
      end

      def load_credentials
        @token = encoder("#{username}:#{password}")
        self
      end

      def encoder(target)
        Base64.encode64(target).gsub("\n", "")
      end

      def decoder(target)
        Base64.decode64(target)
      end
    end
  end
end
