# encoding: utf-8

require 'test_helper'
require 'earth_tools'
require 'earth_tools/result/sunrise_sunset'
require 'mock_lookup'

##
# Tests for Sunrise/Sunset lookups.
class SunriseSunsetTest < MiniTest::Unit::TestCase
  
  def setup
    @result = EarthTools.sunrise_sunset(40.71417, -74.00639, 12, 4)
    @year = Time.now.year
  end
  
  def test_location
    assert_equal 40.71417, @result.latitude
    assert_equal -74.00639, @result.longitude
    assert_equal [40.71417, -74.00639], @result.location
  end
  
  def test_sunrise_is_time
    sunrise = @result.sunrise
    
    assert_instance_of Time, sunrise
    assert_equal Time.new(@year, 12, 4, 7, 5, 50, '-05:00'), sunrise
  end
  
  def test_sunset
    sunset = @result.sunset
    
    assert_instance_of Time, sunset
    assert_equal Time.new(@year, 12, 4, 16, 26, 59, '-05:00'), sunset
  end
  
  def test_twilight_as_morning_and_astronomical
    morning_astronomical_twilight = @result.twilight(:morning, :astronomical)
    
    assert_instance_of Time, morning_astronomical_twilight
    assert_equal Time.new(@year, 12, 4, 5, 27, 39, '-05:00'), morning_astronomical_twilight
  end
  
  def test_twilight_as_morning_and_civil
    morning_civil_twilight = @result.twilight(:morning, :civil)
    
    assert_instance_of Time, morning_civil_twilight
    assert_equal Time.new(@year, 12, 4, 6, 35, 6, '-05:00'), morning_civil_twilight
  end
  
  def test_twilight_as_morning_and_nautical
    morning_nautical_twilight = @result.twilight(:morning, :nautical)
    
    assert_instance_of Time, morning_nautical_twilight
    assert_equal Time.new(@year, 12, 4, 6, 0, 50, '-05:00'), morning_nautical_twilight
  end
  
  def test_twilight_as_evening_and_astronomical
    evening_astronomical_twilight = @result.twilight(:evening, :astronomical)
    
    assert_instance_of Time, evening_astronomical_twilight
    assert_equal Time.new(@year, 12, 4, 18, 5, 10, '-05:00'), evening_astronomical_twilight
  end
  
  def test_twilight_as_evening_and_civil
    evening_civil_twilight = @result.twilight(:evening, :civil)
    
    assert_instance_of Time, evening_civil_twilight
    assert_equal Time.new(@year, 12, 4, 16, 57, 43, '-05:00'), evening_civil_twilight
  end
  
  def test_twilight_as_evening_and_nautical
    evening_nautical_twilight = @result.twilight(:evening, :nautical)
    
    assert_instance_of Time, evening_nautical_twilight
    assert_equal Time.new(@year, 12, 4, 17, 31, 59, '-05:00'), evening_nautical_twilight
  end
  
  def test_morning_twilight_as_astronomical
    morning_astronomical_twilight = @result.morning_twilight(:astronomical)
    
    assert_instance_of Time, morning_astronomical_twilight
    assert_equal Time.new(@year, 12, 4, 5, 27, 39, '-05:00'), morning_astronomical_twilight
  end
  
  def test_morning_twilight_as_civil
    morning_civil_twilight = @result.morning_twilight(:civil)
    
    assert_instance_of Time, morning_civil_twilight
    assert_equal Time.new(@year, 12, 4, 6, 35, 6, '-05:00'), morning_civil_twilight
  end
  
  def test_morning_twilight_as_nautical
    morning_nautical_twilight = @result.morning_twilight(:nautical)
    
    assert_instance_of Time, morning_nautical_twilight
    assert_equal Time.new(@year, 12, 4, 6, 0, 50, '-05:00'), morning_nautical_twilight
  end
  
  def test_evening_twilight_as_astronomical
    evening_astronomical_twilight = @result.evening_twilight(:astronomical)
    
    assert_instance_of Time, evening_astronomical_twilight
    assert_equal Time.new(@year, 12, 4, 18, 5, 10, '-05:00'), evening_astronomical_twilight
  end
  
  def test_evening_twilight_as_civil
    evening_civil_twilight = @result.evening_twilight(:civil)
    
    assert_instance_of Time, evening_civil_twilight
    assert_equal Time.new(@year, 12, 4, 16, 57, 43, '-05:00'), evening_civil_twilight
  end
  
  def test_evening_twilight_as_nautical
    evening_nautical_twilight = @result.evening_twilight(:nautical)
    
    assert_instance_of Time, evening_nautical_twilight
    assert_equal Time.new(@year, 12, 4, 17, 31, 59, '-05:00'), evening_nautical_twilight
  end
  
  def test_morning_astronomical_twilight
    morning_astronomical_twilight = @result.morning_astronomical_twilight
    
    assert_instance_of Time, morning_astronomical_twilight
    assert_equal Time.new(@year, 12, 4, 5, 27, 39, '-05:00'), morning_astronomical_twilight
  end
  
  def test_morning_civil_twilight
    morning_civil_twilight = @result.morning_civil_twilight
    
    assert_instance_of Time, morning_civil_twilight
    assert_equal Time.new(@year, 12, 4, 6, 35, 6, '-05:00'), morning_civil_twilight
  end
  
  def test_morning_nautical_twilight
    morning_nautical_twilight = @result.morning_nautical_twilight
    
    assert_instance_of Time, morning_nautical_twilight
    assert_equal Time.new(@year, 12, 4, 6, 0, 50, '-05:00'), morning_nautical_twilight
  end
  
  def test_evening_astronomical_twilight
    evening_astronomical_twilight = @result.evening_astronomical_twilight
    
    assert_instance_of Time, evening_astronomical_twilight
    assert_equal Time.new(@year, 12, 4, 18, 5, 10, '-05:00'), evening_astronomical_twilight
  end
  
  def test_evening_civil_twilight
    evening_civil_twilight = @result.evening_civil_twilight
    
    assert_instance_of Time, evening_civil_twilight
    assert_equal Time.new(@year, 12, 4, 16, 57, 43, '-05:00'), evening_civil_twilight
  end
  
  def test_evening_nautical_twilight
    evening_nautical_twilight = @result.evening_nautical_twilight
    
    assert_instance_of Time, evening_nautical_twilight
    assert_equal Time.new(@year, 12, 4, 17, 31, 59, '-05:00'), evening_nautical_twilight
  end
  
  def test_utc_offset
    utc_offset = @result.utc_offset
    
    assert_kind_of Integer, utc_offset
    assert_equal -5, utc_offset
  end
  
  def test_version
    assert_equal 1.0, @result.version
  end
  
end