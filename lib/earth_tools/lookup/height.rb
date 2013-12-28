require 'earth_tools/lookup/base'
require 'earth_tools/result/height'

module EarthTools::Lookup
  
  ##
  # The height lookup.
  #
  class Height < Base
    
    private
    
    def query_base
      "/height/"
    end
    
  end
end