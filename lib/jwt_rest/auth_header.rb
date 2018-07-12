module JwtRest
  class AuthHeader
    def initialize(chunk = "")
      @type, @value = chunk&.split(" ")
      @type = @type&.downcase
    end

    def is_basic?
      type == "basic"
    end

    def is_token?
      type == "bearer"
    end

    def token
      return JwtRest::Tokens::Basic.new(token: value).load_token if is_basic?
      return JwtRest::Tokens::Jwt.new(token: value).load_token if is_token?
    end

    private

    attr_accessor :type, :value
  end
end
