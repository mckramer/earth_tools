require 'earth_tools/result/base'
require 'earth_tools/configuration'

module EarthTools::Result
  class Height < Base

    ##
    # Returns height based on unit requested in configuration
    #
    def height
      if EarthTools::Configuration.units == :metric
        meters
      else
        feet
      end
    end
    
    ##
    # The height above sea level in meters
    # See http://en.wikipedia.org/wiki/Meter
    def meters
      @data['meters'].to_f
    end
    
    ##
    # The height above sea level in feet
    # See http://en.wikipedia.org/wiki/Foot_(unit)
    def feet
      @data['feet'].to_f
    end
    
  end
end