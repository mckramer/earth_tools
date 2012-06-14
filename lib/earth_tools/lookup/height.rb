require 'earth_tools/lookup/base'
require 'earth_tools/result/height'

module EarthTools::Lookup
  class Height < Base
    
    private

    def query_base
      "/height/"
    end
    
  end
end