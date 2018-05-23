require "spec_helper"

describe JwtRest::Tokens::Basic do
  basic_token_boilerplate

  describe "#load_token" do
    it "decodes the token from the authentication basic format" do
      basic = described_class.new(token: basic_token).load_token
      expect(basic.username).to eq(username)
      expect(basic.password).to eq(password)
    end
  end

  describe "#load_credentials" do
    it "encodes the credentials into a Basic token" do
      basic = described_class.new(username: username, password: password).load_credentials
      expect(basic.token).to eq(basic_token)
    end
  end
end
