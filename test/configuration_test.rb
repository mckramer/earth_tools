# encoding: utf-8
require 'test_helper'
 
class ConfigurationTest < MiniTest::Unit::TestCase
  
  def setup
    EarthTools::Configuration.set_defaults
  end
  
  def test_configure_by_class_method
    EarthTools::Configuration.units = :metric
    assert_equal :metric, EarthTools::Configuration.units
    
    result = EarthTools.height(52.4822, -1.8946)
    refute_equal result.height, result.feet
  end
  
  def test_block_configuration
    EarthTools.configure do |config|
      config.units  = :metric
    end
    assert_equal :metric, EarthTools::Configuration.units
    
    result = EarthTools.height(52.4822, -1.8946)
    refute_equal result.height, result.feet
    
  end
  
  def test_property_configuration
    EarthTools.configure.units  = :metric
    assert_equal :metric, EarthTools::Configuration.units
    
    result = EarthTools.height(52.4822, -1.8946)
    assert_equal result.height, result.meters
    refute_equal result.height, result.feet
  end
  
end