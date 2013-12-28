# encoding: utf-8
require 'test_helper'
 
class ConfigurationTest < MiniTest::Unit::TestCase
  
  def setup
    EarthTools::Configuration.set_defaults
  end
  
  # --- class method configuration ---
  def test_configurated_by_class_method
    EarthTools::Configuration.units = :metric
    assert_equal EarthTools::Configuration.units, :metric
    result = EarthTools.height(52.4822, -1.8946)
    if result.height == 0
      assert_equal result.height, result.feet
    else
      refute_equal result.height, result.feet
    end
  end
  
  # --- EarthTools#configure distances configuration ---
  def test_configuration
    
    # DSL
    EarthTools.configure do |config|
      config.units  = :metric
    end
    
    assert_equal EarthTools::Configuration.units, :metric
    result = EarthTools.height(52.4822, -1.8946)
    if result.height == 0
      assert_equal result.height, result.feet
    else
      refute_equal result.height, result.feet
    end
    
    # Direct
    EarthTools.configure.units  = :metric
    
    assert_equal EarthTools::Configuration.units, :metric
    result = EarthTools.height(52.4822, -1.8946)
    assert_equal result.height, result.meters
    if result.height == 0
      assert_equal result.height, result.feet
    else
      refute_equal result.height, result.feet
    end
  end
  
end