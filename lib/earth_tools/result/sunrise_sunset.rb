require 'earth_tools/result/base'

module EarthTools::Result

  ##
  # The sunrise/sunset result object
  #
  class SunriseSunset < Base
  
    ##
    # The date of the sunrise/sunset data as a hash
    # @return [Hash] Hash containing year, month, and day as integers
    def date
      { :year => Time.now.year, :month => @data['date']['month'].to_i, :day => @data['date']['day'].to_i }
    end

    ##
    # The sunrise time
    # @return [Time] the sunrise time
    def sunrise
      create_time @data['morning']['sunrise']
    end
    
    ##
    # The sunset time
    # @return [Time] the sunset time
    def sunset
      create_time @data['evening']['sunset']
    end
    
    ##
    # The twilight time for the specified time and type
    # @param [Symbol] the time (:morning or :evening)
    # @param [Symbol] the type (:astronomical, :civil, or :nautical)
    # @return [Time] the requested twilight time
    def twilight(time, type)
      time = time.to_sym if time.is_a?(String)
      type = type.to_sym if type.is_a?(String)
      send "#{time}_#{type}_twilight" if [:morning, :evening].include?(time) && [:astronomical, :civil, :nautical].include?(type)
    end
    
    ##
    # The morning twilight time for the specified type
    # @param [Symbol] the type of morning twilight time
    # @return [Time] the specified morning twilight time
    def morning_twilight(type)
      twilight :morning, type
    end
    
    ##
    # The evening twilight time for the specified type
    # @param [Symbol] the type of evening twilight time
    # @return [Time] the specified evening twilight time
    def evening_twilight(type)
      twilight :evening, type
    end
    
    ##
    # The evening astronomical twilight time
    # @return [Time] the astronomical twilight time for the evening
    def evening_astronomical_twilight
      create_time @data['evening']['twilight']['astronomical']
    end
    
    ##
    # The evening civil twilight time
    # @return [Time] the civil twilight time for the evening
    def evening_civil_twilight
      create_time @data['evening']['twilight']['civil']
    end
    
    ##
    # The evening nautical twilight time
    # @return [Time] the nautical twilight time for the evening
    def evening_nautical_twilight
      create_time @data['evening']['twilight']['nautical']
    end
    
    ##
    # The morning astronomical twilight time
    # @return [Time] the astronomical twilight time for the morning
    def morning_astronomical_twilight
      create_time @data['morning']['twilight']['astronomical']
    end
    
    ##
    # The morning civil twilight time
    # @return [Time] the civil twilight time for the morning
    def morning_civil_twilight
      create_time @data['morning']['twilight']['civil']
    end
    
    ##
    # The morning nautical twilight time
    # @return [Time] the nautical twilight time for the morning
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
    # @returns [Time] The parse time
    def create_time(time)
      times = time.split(':').collect{|s| s.to_i}
      Time.new(date[:year], date[:month], date[:day], times[0], times[1], times[2], utc_offset * 3600)
    end
    
  end
end