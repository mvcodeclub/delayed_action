$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "delayed_action/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "delayed_action"
  s.version     = DelayedAction::VERSION
  s.authors     = ["Douglas Tarr"]
  s.email       = ["douglas.tarr@gmail.com"]
  s.homepage    = "https://github.com/mvcodeclub/delayed_action"
  s.summary     = "Add asynchronous queuing of HTTP requests in one line of code"
  s.description = "Delayed Action is a controller concern that lets you queue long running requests in a DRY fashion to avoid timeouts"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2"

end
