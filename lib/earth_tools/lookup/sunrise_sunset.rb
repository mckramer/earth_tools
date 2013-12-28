require 'earth_tools/lookup/base'
require 'earth_tools/result/sunrise_sunset'

module EarthTools::Lookup
  
  ##
  # The Sunrise/Sunset lookup.
  class SunriseSunset < Base
    
    private
    
    def query_base
      "/sun/"
    end
    
  end
end