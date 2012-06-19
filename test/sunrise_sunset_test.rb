# encoding: utf-8

require 'test_helper'
require 'earth_tools'
require 'earth_tools/result/sunrise_sunset'
require 'mock_lookup'

class SunriseSunsetTest < MiniTest::Unit::TestCase

  def setup
    @result = EarthTools.sunrise_sunset(40.71417, -74.00639, 12, 4)
  end
  
  def test_sunrise_is_time
    assert @result.sunrise.is_a?(Time), 'Sunrise should be a time'
  end
  
  def test_sunrise_parsed_correctly
    assert_equal Time.new(2012, 12, 4, 7, 5, 50, '-05:00'), @result.sunrise, 'Sunrise was not parsed correctly'
  end
  
  def test_sunset_is_time
    assert @result.sunset.is_a?(Time), 'Sunset should be a time'
  end
  
  def test_sunset_parsed_correctly
    assert_equal Time.new(2012, 12, 4, 16, 26, 59, '-05:00'), @result.sunset, 'Sunset was not parsed correctly'
  end
  
end