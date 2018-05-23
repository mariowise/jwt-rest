module JwtRest
  module Secrets
    def self.rsa_private_key
      raise "You should override this method and provide the Base64 encoded of your RSA private key"
    end

    def self.valid_api_key?(api_key)
      raise "You should override this method and provide a way to verify your API_KEYs"
    end

    def self.rsa_private
      pkey = rsa_private_key
      begin
        decoded = Base64.decode64(pkey)
        OpenSSL::PKey::RSA.new(decoded)
      rescue
        raise "Unable to decode your private key. Be sure to provide a valid RSA private key and then apply the Base64 encoding"
      end
    end
  end
end
