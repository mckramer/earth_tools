require 'earth_tools/result/base'

module EarthTools::Result
  class TimeZone < Base

    def dst
      @data['dst']
    end
    
    def dst?
      @data['dst'] == 'True'
    end
    
    def iso_time
      @data['isotime']
    end
    
    def local_time
      @data['localtime']
    end
  
    def offset
      @data['offset']
    end

    def suffix
      @data['suffix']
    end
    
    def utc_time
      @data['utctime']
    end
    
  end
end