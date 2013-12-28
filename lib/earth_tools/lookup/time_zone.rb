require 'earth_tools/lookup/base'
require 'earth_tools/result/time_zone'

module EarthTools::Lookup
  
  ##
  # The Time Zone lookup.
  #
  class TimeZone < Base
    
    private
    
    def query_base
      "/timezone/"
    end
    
  end
end