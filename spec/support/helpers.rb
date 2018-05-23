module Helpers
  def basic_token_boilerplate
    let(:basic_token) { "dXNlcm5hbWU6cGFzc3dvcmQ=" }
    let(:username) { "username" }
    let(:password) { "password" }
  end

  def jwt_token_boilerplate
    let(:rsa_private) { OpenSSL::PKey::RSA.generate(2048) }
    let(:private_key) { Base64.encode64(rsa_private.to_s).gsub("\n", "") }
    let(:payload) { { name: "Mario" } }
    let(:jwt_token) { JWT.encode(payload, rsa_private, 'RS384') }
  end
end

RSpec.configure do |c|
  c.extend Helpers
end
