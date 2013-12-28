# earth_tools
[![Gem Version](https://badge.fury.io/rb/earth_tools.png)](http://badge.fury.io/rb/earth_tools) [![Dependency Status](https://gemnasium.com/mckramer/earth_tools.png?travis)](https://gemnasium.com/mckramer/earth_tools) [![Code Climate](https://codeclimate.com/github/mckramer/earth_tools.png)](https://codeclimate.com/github/mckramer/earth_tools) [![Build Status](https://secure.travis-ci.org/mckramer/earth_tools.png?branch=master)](http://travis-ci.org/mckramer/earth_tools)

`earth_tools` is a wrapper around the wonderful [earthtools.org webservices](http://www.earthtools.org/webservices.htm), which allows you to determine the sea level height, time zone, and surise/sunset times from a set of coordinates.

## Compatibility

* Supports Ruby 1.9.2 & 1.9.3

Will be testing on other versions in the future.

## Installation instructions

Add to your Gemfile:

  `gem 'earth_tools'`

and then bundle your gemfile:

  `bundle install`
  
and you are done!

## API

The run down of the 3 major functions available

### Time zone

    # API
    result = EarthTools.time_zone(latitude, longitude)
    # Example
    result = EarthTools.time_zone(40.71417, -74.00639) # New York City
    result.iso_time   # => 2012-06-14 12:56:40 -0500
    result.utc_offset # => -5
    result.utc_time   # => 2012-06-14 17:56:40 +0000

### Height above/below sea level

    # API
    result = EarthTools.height(latitude, longitude)
    # Example
    result = EarthTools.height(52.4822, -1.8946) # Birmingham, AL
    result.meters # => 141
    result.feet   # => 462.6
    result.height # => 462.6 (when EarthTools::Configuration.units is set to :english units)

### Sunrise/sunset times

    # API
    result = EarthTools.sunrise_sunset(latitude, longitude, month, day, timezone, dst)
    # Example
    result = EarthTools.sunrise_sunset(40.71417, -74.00639, 12, 4, -5, 0) # New York City, December 4th
    result.sunrise     # => 2012-12-04 07:05:50 -0500
    result.sunset      # => 2012-12-04 16:26:59 -0500

### Configuration

    # Configure block (set to defaults)
    EarthTools.configure do |config|
      config.always_raise = []              # Add any errors that you would like to be custom handled, see "Error handling" section below
      config.cache = nil                    # Cache object (see Caching section for what methods are required)
      config.cache_prefix = "earth_tools:"  # Prefix to use for cache keys
      config.timeout = 3                    # Timeout in seconds
      config.units = :english               # Also, can specify :metric
    end
    # Static call
    EarthTools::Configuration.timeout = 5   # Set timeout to 5 seconds

## Earth Tool API restrictions

### Limits

Earth Tools imposes some [usage restrictions](http://www.earthtools.org/webservices.htm#usage) that are duplicated below (these restrictions may not be kept up-to-date, so please check the website):

1. You *must not* make more than 1 (one) request per second to these webservices.
2. You *must* cache results if you believe that you will need to make another identical request within any 24-hour period.
3. You *must* delete any cached data when you no longer need it and in any case after 14 days. You should then make a new request for the data in line with the previous two rules. If you wish to keep access to data I am able to license the data for use in this way.

### Caching

It is recommended to cache retrieved data when relying on an external service. You can configure a cache store:

    EarthTools::Configuration.cache = Redis.new
    EarthTools::Configuration.cache_prefix = "..." # Provide a custom cache prefix, defaults to 'earth_tools:'

The cache store can be any object that supports the following methods:

<table>
    <tr>
        <th>Method</th><th>Description</th><th>Examples</th>
    </tr>
    <tr>
        <td><code>#[](key)</code></td><td>Retrieves a value by with the key</td><td></td>
    </tr>
    <tr>
        <td><code>#[]=(key, value)</code></td><td>Stores a value with the key</td><td></td>
    </tr>
    <tr>
        <td><code>#keys</code></td><td>Retrieves all keys</td><td></td>
    </tr>
    <tr>
        <td>
            <div><code>#del</code></div>
            <div>or</div>
            <div><code>#delete</code></div>
        </td>
        <td>Deletes a key</td>
        <td></td>
    </tr>
</table>

If you need to expire cached content:

    EarthTools.cache.expire("http://...") # Expire cached result for a URL
    EarthTools.cache.expire(:all)         # Expire all cached results

There is no need to include the prefix when passing a URL to be expired. Expiring `:all` will only expire keys with the configured prefix (won't kill every entry in your key/value store).

## Error handling

By default Earth Tools will rescue any exceptions raised by calls to the webservice and return an empty array (using warn() to inform you of the error). You can override this and implement custom error handling for certain exceptions by using the `:always_raise` option:

    EarthTools::Configuration.always_raise = [SocketError, TimeoutError]

## Issues & contributing

No outstanding issues right now.  Please post any issues to the [issues queue on github](https://github.com/mckramer/earth_tools/issues).

## Future

I would love to see this functionality brought into the `geocoder` gem or similar in the future.

# License and attributions

This gem's structure and design borrows heavily from `geocoder`, so thanks to its author.  Find me on twitter [@maxckramer](https://twitter.com/maxckramer).