# encoding: utf-8

require 'test_helper'
require 'earth_tools'
require 'earth_tools/result/height'
require 'mock_lookup'

##
# Tests for height lookups.
class HeightTest < MiniTest::Unit::TestCase

  def setup
    @result = EarthTools.height(52.4822, -1.8946)
  end
  
  # @see configuration_test.rb for tests for height configuration
  def test_height
    assert_instance_of Float, @result.height
  end
  
  def test_feet
    feet = @result.feet
    assert_instance_of Float, feet
    assert_equal 462.6, feet
  end
  
  def test_meters
    meters = @result.meters
    
    assert_instance_of Float, meters
    assert_equal 141, meters
  end
  
end