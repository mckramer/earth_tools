##
#
#
#
module EarthTools
  extend self
  
  ##
  # Retrieve for time zone based on latitude and longitude.
  # @returns [EarthTools::Result::TimeZone] the time zone result
  def time_zone(latitude, longitude)
    get_lookup(:time_zone).search(latitude, longitude) if valid_input?(latitude, longitude)
  end
  
  ##
  # Retrieve the sunrise & sunset values.
  # @return [EarthTools::Result::SunriseSunset] the sunrise/sunset result
  def sunrise_sunset(latitude, longitude, month, day, timezone = 99, dst = false)
    get_lookup(:sunrise_sunset).search(latitude, longitude, day, month, timezone, dst ? 1 : 0)
  end
  
  ##
  # Retrieve the land height for a given latitude and longitude.
  # @return [EarthTools::Result::Height] the height result
  def height(latitude, longitude)
    get_lookup(:height).search(latitude, longitude)
  end
  
  private
  
  ##
  # Retrieve a lookup object from the store.
  # @return [? extends EarthTools::Lookup::Base]
  def get_lookup(name)
    @lookups = {} unless defined?(@lookups)
    @lookups[name] = spawn_lookup(name) unless @lookups.include?(name)
    @lookups[name]
  end
  
  ##
  # Spawn a lookup of the given name.
  # @return [? extends EarthTools::Lookup::Base] new lookup helper
  def spawn_lookup(name)
    name = name.to_s
    require "earth_tools/lookup/#{name}"
    klass = name.split("_").map{ |i| i[0...1].upcase + i[1..-1] }.join
    EarthTools::Lookup.const_get(klass).new
  end
  
  ##
  # Validates input.
  # @return [Boolean] true, if coordinates are valid
  def valid_input?(latitude, longitude)
    coordinates?(latitude, longitude)
  end
  
  ##
  # Validates input.
  # @return [Boolean] true, if all values are valid
  def valid_full_input?(latitude, longitude, day, month, timezone, dst)
    coordinates?(latitude, longitude) && !blank?(day) && !blank(month) && !blank?(timezone) && !blank?(dst)
  end
  
  ##
  # Validates a pair of coordinates.
  # @return [Boolean] true, if latitute and longitude are (sort of) valid coordinates
  def coordinates?(latitude, longitude)
    coordinate?(latitude) && coordinate?(longitude)
  end
  
  ##
  # Determine if given value is a coordinate.
  # @return [Boolean] true, if given value is a coordinate
  def coordinate?(value)
    !! value.to_f
  end
  
  ##
  # Determine if given value is blank.
  # @return [Boolean] true, if value is nil or empty
  def blank?(value)
    value.nil? || value.to_s.empty?
  end
  
end