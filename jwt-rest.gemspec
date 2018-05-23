$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "jwt_rest/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "jwt-rest"
  s.version     = JwtRest::VERSION
  s.authors     = ["mariowise"]
  s.email       = ["mariolopezlandes@gmail.com"]
  s.homepage    = "https://github.com/mariowise/jwt-rest"
  s.summary     = "A security layer for any API REST in Rails with JWT tokens."
  s.description = "A security layer for any API REST in Rails with JWT tokens."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.6"
  s.add_dependency "jwt", "~> 2.1.0"

  s.add_development_dependency "pry"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
