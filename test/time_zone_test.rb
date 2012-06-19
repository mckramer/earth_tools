# encoding: utf-8

require 'test_helper'
require 'earth_tools'
require 'earth_tools/result/time_zone'
require 'mock_lookup'

class TimeZoneTest < MiniTest::Unit::TestCase

  def setup
    @result = EarthTools.time_zone(40.71417, -74.00639)
  end
  
  def test_time_zone_method_returns_result_object
    assert @result.is_a?(EarthTools::Result::TimeZone), 'Result should be a time zone object'
  end
  
  def test_iso_time_is_time
    assert @result.iso_time.is_a?(Time), 'ISO time should be a time object'
  end
  
  def test_iso_time_parsed_correctly
    assert_equal Time.new(2012, 6, 14, 13, 29, 6, '-05:00'), @result.iso_time, 'ISO time was not parsed correctly'
  end
  
  def test_local_time_is_time
    assert @result.local_time.is_a?(Time), 'Local time should be a time object'
  end
  
  def test_local_time_parsed_correctly
    assert_equal Time.new(2012, 6, 14, 13, 29, 6, '-05:00'), @result.local_time, 'Local time was not parsed correctly'
  end
  
  def test_suffix_is_string
    assert @result.suffix.is_a?(String), 'Suffix should be a string'
  end
  
  def test_suffix_parsed_correctly
    assert_equal 'R', @result.suffix, 'Suffix was not parsed correctly'
  end
  
  def test_utc_offset_is_integer
    assert @result.utc_offset.is_a?(Integer), 'UTC offset should be an integer'
  end
  
  def test_utc_offset_parsed_correctly
    assert_equal -5, @result.utc_offset, 'UTC offset was not parsed correctly'
  end
  
  def test_utc_time_is_time
    assert @result.utc_time.is_a?(Time), 'UTC time should be a time object'
  end
  
  def test_utc_time_parsed_correctly
    assert_equal Time.utc(2012, 6, 14, 18, 29, 6), @result.utc_time, 'UTC time was not parsed correctly'
  end
  
end