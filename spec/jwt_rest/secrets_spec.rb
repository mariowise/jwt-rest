require "spec_helper"

describe JwtRest::Secrets do
  describe "#rsa_private_key" do
    it "demands the developer to fix override the method" do
      expect { described_class.rsa_private_key }.to raise_error(StandardError)
    end
  end

  describe "#rsa_private" do
    it "checks if the RSA_PRIVATE is a Base64 encoded and valid RSA private key" do
      described_class.define_singleton_method :rsa_private_key do
        "asdf"
      end
      expect { described_class.rsa_private }.to raise_error(/^Unable to decode your private key.*/)
    end

    it "returns a valid RSA private key" do
      sample = OpenSSL::PKey::RSA.generate 2048
      sample = Base64.encode64(sample.to_s).gsub("\n", "")
      described_class.define_singleton_method :rsa_private_key do
        sample
      end
      expect(described_class.rsa_private).to be_an(OpenSSL::PKey::RSA)
    end
  end
end
