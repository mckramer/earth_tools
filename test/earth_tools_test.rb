# encoding: utf-8

require 'test_helper'
require 'earth_tools'
require 'earth_tools/result/height'
require 'earth_tools/result/sunrise_sunset'
require 'earth_tools/result/time_zone'
require 'mock_lookup'

##
# Tests for module static methods.
class EarthToolsTest < MiniTest::Unit::TestCase
  
  def test_time_zone_method_returns_result_object
    assert_instance_of EarthTools::Result::TimeZone, EarthTools.time_zone(40.71417, -74.00639)
  end
  
  def test_sunrise_sunset_method_returns_result_object
    assert_instance_of EarthTools::Result::SunriseSunset, EarthTools.sunrise_sunset(40.71417, -74.00639, 12, 4)
  end
  
  def test_height_method_returns_result_object
    assert_instance_of EarthTools::Result::Height, EarthTools.height(52.4822, -1.8946)
  end
  
end
