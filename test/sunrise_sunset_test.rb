# encoding: utf-8

require 'test_helper'
require 'earth_tools'
require 'earth_tools/result/sunrise_sunset'
require 'mock_lookup'

class SunriseSunsetTest < MiniTest::Unit::TestCase

  def setup
    @result = EarthTools.sunrise_sunset(40.71417, -74.00639, 12, 4)
  end
  
  # ---------------------------------------------------------------------------
  # sunrise
  # ---------------------------------------------------------------------------
  
  def test_sunrise_is_time
    assert @result.sunrise.is_a?(Time), 'Sunrise should be a time'
  end
  
  def test_sunrise_parsed_correctly
    assert_equal Time.new(Time.now.year, 12, 4, 7, 5, 50, '-05:00'), @result.sunrise, 'Sunrise was not parsed correctly'
  end
  
  # ---------------------------------------------------------------------------
  # sunset
  # ---------------------------------------------------------------------------
  
  def test_sunset_is_time
    assert @result.sunset.is_a?(Time), 'Sunset should be a time'
  end
  
  def test_sunset_parsed_correctly
    assert_equal Time.new(Time.now.year, 12, 4, 16, 26, 59, '-05:00'), @result.sunset, 'Sunset was not parsed correctly'
  end
  
  # ---------------------------------------------------------------------------
  # twilight :time, :type
  # ---------------------------------------------------------------------------
  
  def test_twilight_is_time
    assert @result.twilight(:morning, :astronomical).is_a?(Time), 'Twilight should be a time'
    assert @result.twilight(:morning, :civil).is_a?(Time), 'Twilight should be a time'
    assert @result.twilight(:morning, :nautical).is_a?(Time), 'Twilight should be a time'
    assert @result.twilight(:evening, :astronomical).is_a?(Time), 'Twilight should be a time'
    assert @result.twilight(:evening, :civil).is_a?(Time), 'Twilight should be a time'
    assert @result.twilight(:evening, :nautical).is_a?(Time), 'Twilight should be a time'
  end
  
  def test_twilight_parsed_correctly
    year = Time.now.year
    assert_equal Time.new(year, 12, 4, 5, 27, 39, '-05:00'), @result.twilight(:morning, :astronomical), 'Twilight was not parsed correctly'
    assert_equal Time.new(year, 12, 4, 6, 35, 6, '-05:00'), @result.twilight(:morning, :civil), 'Twilight was not parsed correctly'
    assert_equal Time.new(year, 12, 4, 6, 0, 50, '-05:00'), @result.twilight(:morning, :nautical), 'Twilight was not parsed correctly'
    assert_equal Time.new(year, 12, 4, 18, 5, 10, '-05:00'), @result.twilight(:evening, :astronomical), 'Twilight was not parsed correctly'
    assert_equal Time.new(year, 12, 4, 16, 57, 43, '-05:00'), @result.twilight(:evening, :civil), 'Twilight was not parsed correctly'
    assert_equal Time.new(year, 12, 4, 17, 31, 59, '-05:00'), @result.twilight(:evening, :nautical), 'Twilight was not parsed correctly'
  end
  
  # ---------------------------------------------------------------------------
  # morning_twilight :type
  # ---------------------------------------------------------------------------
  
  # ---------------------------------------------------------------------------
  # evening_twilight :type
  # ---------------------------------------------------------------------------
  
  # ---------------------------------------------------------------------------
  # *_*_twilight
  # ---------------------------------------------------------------------------
  
  def test_morning_astronomical_twilight_is_time
    assert @result.morning_astronomical_twilight.is_a?(Time), 'Morning astronomical twilight should be a time'
  end
  
  def test_morning_astronomical_twilight_parsed_correctly
    assert_equal Time.new(Time.now.year, 12, 4, 5, 27, 39, '-05:00'), @result.morning_astronomical_twilight, 'Twilight was not parsed correctly'
  end
  
  # ---------------------------------------------------------------------------
  # utc_offset
  # ---------------------------------------------------------------------------
  
  def test_utc_offset_is_integer
	assert @result.utc_offset.is_a?(Integer), 'UTC offset should be an integer'
  end
  
  def test_utc_offset_parsed_correctly
    assert_equal -5, @result.utc_offset, 'UTC offset was not parsed correctly'
  end
  
end