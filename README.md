# jwt-rest

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'jwt-rest'
```

And then execute:
```bash
$ bundle
```

## Usage

First you will need to provide a way to find if the ApiKey is valid or not, and a way to retrieve the RSA private key to sign JWT tokens. For this, lets create a initializer `config/initializers/jwt_rest.rb`.

```ruby
require "jwt_rest"

module JwtRest
  module Secrets
    def self.rsa_private_key
      # return he Base64 encoded of your RSA private key
    end

    def self.valid_api_key?(api_key)
      # return true if the api_key is valid
    end
  end
end
```

Then in your API's base controller do this

```ruby
class ApiController < ActionController::API
  include JwtRest::Authenticable

  before_action :demand_api_key

  def handle_user_identity(jwt_payload)
    return false unless @current_user = User.find_by(email: jwt_payload.dig("email"))
    true
  end
end
```

This will ensure that every call to your API i
s made with a valid api key. You could use the method `demand_current_user` for those endpoins where you need to authenticate the user with the JWT token.

```ruby
class UsersController < ApiController
  before_action :demand_current_user, only: [:profile]

  def profile
    # here we have the @current_user variable
  end
end
```

## Contributing
Contribution directions go here.

### TODO

* Multiple RSA algorithm types for the JWT token

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
