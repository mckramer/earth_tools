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
    def twilight(time, type)
      time = time.to_sym if time.is_a?(String)
      type = type.to_sym if type.is_a?(String)
      send "#{time}_#{type}_twilight" if [:morning, :evening].include?(time) && [:astronomical, :civil, :nautical].include?(type)
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