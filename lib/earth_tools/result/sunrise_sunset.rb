require 'earth_tools/result/base'

module EarthTools::Result

  ##
  #
  #
  class SunriseSunset < Base
  
    ##
    # 
    # @return [Hash] Hash containing year, month, and day as integers
    def date
      { :year => Time.now.year, :month => @data['date']['month'].to_i, :day => @data['date']['day'].to_i }
    end

    ##
    # The sunrise
    # @return [Time]
    def sunrise
      create_time @data['morning']['sunrise']
    end
    
    ##
    # The sunset
    # @return [Time]
    def sunset
      create_time @data['evening']['sunset']
    end
    
    ##
    # The twilight 
    # @param [Symbol]
    # @param [Symbol]
    # @return [Time]
    def twilight(morning_or_evening, type)
      morning_or_evening = morning_or_evening.to_sym if morning_or_evening.is_a?(String)
      case morning_or_evening
      when :morning
        morning_twilight type
      when :evening
        evening_twilight type
      end    
    end
    
    ##
    # The evening twilight 
    # @param [Symbol]
    # @return [Time]
    def evening_twilight(type)
      type = type.to_sym if type.is_a?(String) # Convert type to symbol if it is a string
      case type
      when :astronomical 
        evening_astronomical_twilight
      when :civil 
        evening_civil_twilight
      when :nautical 
        evening_nautical_twilight
      end
    end
    
    ##
    # The morning twilight 
    # @param [Symbol]
    # @return [Time]
    def morning_twilight(type)
      type = type.to_sym if type.is_a?(String) # Convert type to symbol if it is a string
      case type
      when :astronomical 
        morning_astronomical_twilight
      when :civil 
        morning_civil_twilight
      when :nautical 
        morning_nautical_twilight
      end
    end
    
    def evening_astronomical_twilight
      create_time @data['evening']['twilight']['astronomical']
    end
    
    def evening_civil_twilight
      create_time @data['evening']['twilight']['civil']
    end
    
    def evening_nautical_twilight
      create_time @data['evening']['twilight']['nautical']
    end
    
    def morning_astronomical_twilight
      create_time @data['morning']['twilight']['astronomical']
    end
    
    def morning_civil_twilight
      create_time @data['morning']['twilight']['civil']
    end
    
    def morning_nautical_twilight
      create_time @data['morning']['twilight']['nautical']
    end
    
    ##
    # The number of hours offset from UTC disregarding any correction for daylight saving time
    # See {http://en.wikipedia.org/wiki/UTC_offset}.
    # @return [Integer] the UTC offset
    def utc_offset
      @data['date']['timezone'].to_i
    end
    
    private 
    
    ##
    # Parses time
    # @returns [Time]
    def create_time(time)
      times = time.split(':').collect{|s| s.to_i}
      Time.new(date[:year], date[:month], date[:day], times[0], times[1], times[2], utc_offset * 3600)
    end
    
  end
end