require 'earth_tools/result/base'

module EarthTools::Result
  
  ##
  # The Time Zone result.
  #
  # @see http://www.earthtools.org/webservices.htm#timezone
  class TimeZone < Base
    
    ##
    # Whether or not the {#local_time} and {#iso_time} is currently in DST. If they do, the value of this element will be 'True'. If they do not, the value will be 'False'. If it can't be determined whether or not daylight saving time should be used, the value will be 'Unknown'. 
    # @return [String] 'True' || 'False' || 'Unknown'
    def dst
      @data['dst']
    end
    
    ##
    # Whether or not the {#local_time} and {#iso_time} is currently in DST
    # @return [boolean] true || false || nil
    def dst?
      case dst
      when 'True' then 
        true
      when 'False'
        false
      else
        nil
      end
    end
    
    ##
    # The same value as {#local_time} but in ISO 8601 format instead
    # See {http://en.wikipedia.org/wiki/ISO_8601}.
    # @return [String] the ISO time
    def iso_time
      create_time @data['isotime']
    end
    
    ##
    # The local time taking into account the time zone offset and any local daylight saving time in effect
    # @return [String] the local time
    def local_time
      iso_time
    end
    
    ##
    # The number of hours offset from UTC disregarding any correction for daylight saving time
    # See {http://en.wikipedia.org/wiki/UTC_offset}.
    # @return [Integer] the UTC offset
    def utc_offset
      @data['offset'].to_i
    end
    
    ##
    # The nautical suffix for the time zone
    # See {http://en.wikipedia.org/wiki/Nautical_time}
    # @return [String] the nautical suffix for the time zone
    def suffix
      @data['suffix']
    end
    
    ##
    # The reference UTC time
    # See {http://en.wikipedia.org/wiki/Coordinated_Universal_Time}.
    # @return [String] the UTC time
    def utc_time
      create_time @data['utctime'], "%Y-%m-%d %H:%M:%S"
    end
    
    private
    
    def create_time(time, format = "%Y-%m-%d %H:%M:%S %z")
      require 'date'
      DateTime.strptime(time, format).to_time
    end
    
  end
end