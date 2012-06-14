require 'earth_tools/result/base'

module EarthTools::Result
  class SunriseSunset < Base
  
    def date
      { :year => @data['date']['year'], :month => @data['date']['month'], :day => @data['date']['day'] }
    end

    ##
    # The sunrise
    #
    def sunrise
      create_time @data['morning']['sunrise']
    end
    
    ##
    # The sunset
    #
    def sunset
      create_time @data['evening']['sunset']
    end
    
    ##
    # The twilight 
    def twilight(type)
    
      case type
      when :astronomical 
        create_time @data['evening']['twilight']['astronomical']
      when :civil 
        create_time @data['evening']['twilight']['civil']
      when :nautical 
        create_time @data['evening']['twilight']['nautical']
      end
    
    end
    
    def utc_offset
      @data['date']['timezone']
    end
    
    private 
    
    def create_time(time)
      times = time.split(':')
      Time.new(date.year, date.month, date.day, times[0], times[1], times[2], utc_offset)
    end
    
  end
end