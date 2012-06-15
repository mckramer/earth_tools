require 'rubygems'
require 'minitest/autorun'
require 'earth_tools'
require 'test_helper'

class SunriseSunsetSmokeTest < MiniTest::Unit::TestCase

  def test_sunrise_sunset_search
    result = EarthTools.sunrise_sunset(40.71417, -74.00639, 9, 11, 0, 0)
    
    assert_equal Time.utc(Time.now.year, 11, 9, 11, 37, 32), result.sunrise
    assert_equal Time.utc(Time.now.year, 11, 9, 21, 41, 12), result.sunset
  end

end