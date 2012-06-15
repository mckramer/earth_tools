require 'rubygems'
require 'minitest/autorun'
require 'earth_tools'
require 'test_helper'

class HeightSmokeTest < MiniTest::Unit::TestCase

  def test_height_search
    result = EarthTools.height(52.4822, -1.8946)
    
    default_units = EarthTools::Configuration.units
    begin
      
      # Default as :english
      assert_equal 462.6, result.height
      
      # Set to :metric units
      EarthTools::Configuration.units = :metric
      assert_equal 141, result.height
      
      # Set to :english units
      EarthTools::Configuration.units = :english
      assert_equal 462.6, result.height
    ensure
      EarthTools::Configuration.units = default_units
    end
    
  end

end