module JwtRest
  module Authenticable
    def demand_application_json
      unless request.format.symbol == :json
        render status: :not_acceptable, json: { error: "only application/json Content-Tyle is allowed" }
      end
    end

    def demand_api_key
      api_key = request.headers["HTTP_X_API_KEY"]
      unless JwtRest::Secrets.valid_api_key?(api_key)
        render status: :unauthorized, json: { error: "invalid api key" }
      end
    end

    def demand_current_user
      header = JwtRest::AuthHeader.new(request.headers["HTTP_AUTHORIZATION"])
      unless header.is_token? && header.token && handle_user_identity(header.token.payload)
        render status: :unauthorized, json: { error: "invalid authorization token" }
      end
    end

    # To be defined by the developer
    # def handle_user_identity(jwt_payload)
    #   true if the users is valid
    # end

    attr_reader :current_user
  end
end
