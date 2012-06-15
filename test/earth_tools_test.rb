# encoding: utf-8

require 'test_helper'
require 'earth_tools'
require 'earth_tools/result/height'
require 'earth_tools/result/sunrise_sunset'
require 'earth_tools/result/time_zone'
require 'mock_lookup'

class EarthToolsTest < MiniTest::Unit::TestCase
  
  def test_time_zone_method_returns_result_object
    EarthTools.time_zone(40.71417, -74.00639).is_a? EarthTools::Result::TimeZone
  end
  
  def test_sunrise_sunset_method_returns_result_object
    EarthTools.sunrise_sunset(40.71417, -74.00639, 12, 4).is_a? EarthTools::Result::SunriseSunset
  end
  
  def test_height_method_returns_result_object
    EarthTools.height(52.4822, -1.8946).is_a? EarthTools::Result::Height
  end
  
end
