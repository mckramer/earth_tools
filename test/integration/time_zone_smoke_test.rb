require 'rubygems'
require 'minitest/autorun'
require 'earth_tools'
require 'test_helper'

class TimeZoneSmokeTest < MiniTest::Unit::TestCase

  def test_time_zone_search
    result = EarthTools.time_zone(40.71417, -74.00639)
    assert_equal -5, result.offset
  end

end