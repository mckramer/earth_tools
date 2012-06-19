# encoding: utf-8

require 'test_helper'
require 'earth_tools'
require 'earth_tools/result/height'
require 'mock_lookup'

##
#
#
class HeightTest < MiniTest::Unit::TestCase

  def setup
    @result = EarthTools.height(52.4822, -1.8946)
  end
  
  def test_height_is_float
    assert @result.height.is_a?(Float), 'Height should be a float'
  end
  
  # Tests for height configuration in configuration_test.rb
  
  def test_feet_is_float
    assert @result.feet.is_a?(Float), 'Feet should be a float'
  end
  
  def test_feet_parsed_correctly
    assert_equal 462.6, @result.feet, 'Feet was not parsed correctly'
  end
  
  def test_meters_is_float
    assert @result.meters.is_a?(Float), 'Meters should be a float'
  end
  
  def test_meters_parsed_correctly
    assert_equal 141, @result.meters, 'Meters was not parsed correctly'
  end
  
end