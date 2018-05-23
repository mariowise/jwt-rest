require "spec_helper"

describe JwtRest::Tokens::Jwt do
  jwt_token_boilerplate

  before :each do
    expect(JwtRest::Secrets).to receive(:rsa_private_key).and_return private_key
  end

  describe "#load_payload" do
    it "creates a JWT token" do
      jwt = described_class.new.load_payload
      payload = jwt.token.split(".")[1]
      payload = Base64.decode64(payload)
      payload = JSON.parse(payload)
      expect(payload.dig("exp")).not_to eq(nil)
    end
  end

  describe "#load_token" do
    it "decodes the token payload" do
      jwt = described_class.new(token: jwt_token).load_token
      expect(jwt.payload.dig("name")).to eq("Mario")
    end
  end
end
