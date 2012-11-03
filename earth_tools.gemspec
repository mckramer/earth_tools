require 'rake'
require './lib/earth_tools/version'

Gem::Specification.new do |gem|
  gem.name    = "earth_tools"
  gem.version = EarthTools::VERSION

  gem.author      = "Max Kramer"
  gem.email       = %q{max@maxckramer.com}
  gem.homepage    = %q{http://github.com/mckramer/earth_tools}
  gem.summary     = %q{Client library to query the earthtools.org web services.}
  gem.description = <<-EOF

    The earth_tools gem is a client library to query the earthtools.org web services.
    Available features include determining time zone, sunset/sunrise times, and height
    above sea level for a given longitute/latitude pair.  See the README for more
    information.  Also, please follow the web service restrictions for use described 
    in the README.
  
  EOF

  gem.license     = "MIT"

  gem.files = FileList['README.md', 'CHANGELOG.md', 'Gemfile', 'Rakefile', 'lib/**/*.rb', 'test/**/*'].to_a
  gem.add_runtime_dependency "rest-client", "~> 1.6.1"
  gem.add_runtime_dependency "xml-simple", "~> 1.1.1"
  
end