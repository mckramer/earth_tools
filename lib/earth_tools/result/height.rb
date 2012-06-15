require 'earth_tools/result/base'
require 'earth_tools/configuration'

module EarthTools::Result
  
  ##
  #
  #  
  class Height < Base

    ##
    # Returns height based on unit requested in configuration
    # @return [float] 
    def height
      if EarthTools::Configuration.units == :metric
        meters
      else
        feet
      end
    end
    
    ##
    # The height above sea level in meters
    # See {http://en.wikipedia.org/wiki/Meter}.
    # @return [float] the height above sea level in meters
    def meters
      @data['meters'].to_f
    end
    
    ##
    # The height above sea level in feet
    # See {http://en.wikipedia.org/wiki/Foot_(unit)}.
    # @return [float] the height above sea level in feet
    def feet
      @data['feet'].to_f
    end
    
  end
end