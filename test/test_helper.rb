if ENV["CI"]
  require 'coveralls'
  Coveralls.wear!
end

require 'rubygems'
require 'minitest/autorun'

require 'earth_tools/configuration'
# EarthTools::Configuration.proxy = 'http://www.proxy.com:80'