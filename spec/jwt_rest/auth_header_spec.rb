require "spec_helper"

describe JwtRest::AuthHeader do
  jwt_token_boilerplate
  basic_token_boilerplate

  let(:basic_header) { described_class.new("basic #{basic_token}") }
  let(:jwt_header) { described_class.new("bearer #{jwt_token}") }
  let(:ugly_header) { described_class.new("8923ihwefbmndsfnbdg") }

  before :each do
    allow(JwtRest::Secrets).to receive(:rsa_private_key).and_return private_key
  end

  describe "#is_basic?" do
    it "is able to identify a basic token headers" do
      expect(basic_header.is_basic?).to be_truthy
      expect(ugly_header.is_basic?).to be_falsy
    end
  end

  describe "#is_token?" do
    it "is able to identify a baerer token headers" do
      expect(jwt_header.is_token?).to be_truthy
      expect(ugly_header.is_token?).to be_falsy
    end
  end

  describe "#token" do
    it "parses the basic token" do
      expect(basic_header.token.username).to eq(username)
    end

    it "parses the JWT token" do
      expect(jwt_header.token.payload.dig("name")).to eq("Mario")
    end

    it "return nil on ugly token" do
      expect(ugly_header.token).to be_nil
    end
  end
end
