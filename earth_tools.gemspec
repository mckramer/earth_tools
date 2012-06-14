require 'rake'
Gem::Specification.new do |gem|
  gem.name    = "earth_tools"
  gem.version = '0.0.1.alpha'

  gem.author      = "Max Kramer"
  gem.email       = "max@maxkramer.me"
  gem.homepage    = "http://github.com/mckramer/earth_tools"
  gem.summary     = "Client library to query the earthtools.org web services"
  gem.description = "Client library to query the earthtools.org web services"
  gem.license     = "MIT"

  gem.files = FileList['lib/**/*.rb', 'test/**/*].to_a

  gem.add_runtime_dependency "rest-client", "~> 1.6.1"
  gem.add_runtime_dependency "", "~> 1.6.1"
end