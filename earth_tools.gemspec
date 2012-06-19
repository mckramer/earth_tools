require 'rake/file_list'
require './lib/earth_tools/version'

Gem::Specification.new do |gem|
  gem.name    = "earth_tools"
  gem.version = EarthTools::VERSION

  gem.author      = "Max Kramer"
  gem.email       = %q{max@maxkramer.me}
  gem.homepage    = %q{http://github.com/mckramer/earth_tools}
  gem.summary     = %q{Client library to query the earthtools.org web services}
  gem.description = %q{Client library to query the earthtools.org web services}
  gem.license     = "MIT"

  gem.files = FileList['lib/**/*.rb', 'test/**/*'].to_a
  gem.add_runtime_dependency "rest-client", "~> 1.6.1"
  gem.add_runtime_dependency "xml-simple", "~> 1.1.1"
  
end