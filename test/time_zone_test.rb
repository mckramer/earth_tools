# encoding: utf-8

require 'test_helper'
require 'earth_tools'
require 'earth_tools/result/time_zone'
require 'mock_lookup'

##
# Tests for Time Zone lookups.
class TimeZoneTest < MiniTest::Unit::TestCase
  
  def setup
    @result  = EarthTools.time_zone(40.71417, -74.00639)
    @result2 = EarthTools.time_zone(40.71655, -12.12318)
    @result3 = EarthTools.time_zone(50.21655, -54.87656)
  end
  
  def test_time_zone_returns_result
    assert_instance_of EarthTools::Result::TimeZone, @result
  end
  
  def test_iso_time
    iso_time = @result.iso_time
    
    assert_instance_of Time, iso_time
    assert_equal Time.new(2012, 6, 14, 13, 29, 6, '-05:00'), iso_time
  end
  
  def test_local_time
    local_time = @result.local_time
    
    assert_instance_of Time, local_time
    assert_equal Time.new(2012, 6, 14, 13, 29, 6, '-05:00'), local_time
  end
  
  def test_suffix
    suffix = @result.suffix
    
    assert_instance_of String, suffix
    assert_equal 'R', suffix
  end
  
  def test_utc_offset
    utc_offset = @result.utc_offset
    
    assert_kind_of Integer, utc_offset
    assert_equal -5, utc_offset
  end
  
  def test_utc_time
    utc_time = @result.utc_time
    
    assert_instance_of Time, utc_time
    assert_equal Time.utc(2012, 6, 14, 18, 29, 6), utc_time
  end
  
  def test_dst_as_true
    assert_equal 'True', @result2.dst
    assert @result2.dst?
  end
  
  def test_dst_as_false
    assert_equal 'False', @result3.dst
    refute @result3.dst?
  end
  
  def test_dst_as_unknown
    assert_equal 'Unknown', @result.dst
    assert_nil @result.dst?
  end
  
end