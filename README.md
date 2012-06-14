# earth_tools

[![Build Status](https://secure.travis-ci.org/mckramer/earth_tools.png?branch=master)](http://travis-ci.org/mckramer/earth_tools) [![Dependency Status](https://gemnasium.com/mckramer/earth_tools.png?travis)](https://gemnasium.com/mckramer/earth_tools)

`earth_tools` is a wrapper around the wonderful [earthtools.org webservices](http://www.earthtools.org/webservices.htm), which allows you to determine the sea level height, time zone, and surise/sunset times from a set of coordinates.

## Compatibility

* Supports Ruby 1.9.2

Will be testing on other versions in the future.

## Installation

Add to your Gemfile:

  `gem "earth_tools"`

and then bundle your gemfile:

  `bundle install`
  
and you are done!

## API

The run down of the 3 major functions available

### Time zone

    # API
    result = EarthTools::time_zone(latitude, longitude)
    # Example
    result = EarthTools::time_zone(40.71417, -74.00639) # New York City
    result.iso_time # returns "2012-06-14 12:56:40 -0500"
    result.offset   # returns "-5"
    result.utc_time # returns "2012-06-14 17:56:40"

### Height above/below sea level

    # API
    result = EarthTools::time_zone(latitude, longitude)
    # Example
    result = EarthTools::time_zone(52.4822/-1.8946) # Birmingham, AL
    result.meters # = 141
    result.feet   # = 462.6
    result.height # = 462.6 when EarthTools::Configuration is set to english units

### Sunrise/sunset times

    # API
    result = EarthTools::time_zone(latitude, longitude)
    # Example
    result = EarthTools::sunrise_sunset(40.71417, -74.00639) # New York City
    result.utc_time # returns ""


## Earth Tool API restrictions

### Limits

Earth Tools imposes some [usage restrictions](http://www.earthtools.org/webservices.htm#usage) that are copies below (these restrictions may be out of date, so please check the website):

1. You *must not* make more than 1 (one) request per second to these webservices.
2. You *must* cache results if you believe that you will need to make another identical request within any 24-hour period.
3. You *must* delete any cached data when you no longer need it and in any case after 14 days. You should then make a new request for the data in line with the previous two rules. If you wish to keep access to data I am able to license the data for use in this way.

### Caching

It's a good idea, when relying on any external service, to cache retrieved data. When implemented correctly it improves your app's response time and stability. It's easy to cache geocoding results with Geocoder, just configure a cache store:

  EarthTools::Configuration.cache = Redis.new

This example uses Redis, but the cache store can be any object that supports these methods:

* `store#[](key)`         - retrieves a value
* `store#[]=(key, value)` - stores a value
* `store#keys`            - lists all keys

Even a plain Ruby hash will work, though it's not a great choice (cleared out when app is restarted, not shared between app instances, etc).

You can also set a custom prefix to be used for cache keys:

  EarthTools::Configuration.cache_prefix = "..."

By default the prefix is `earth_tools:`

If you need to expire cached content:

  EarthTools.cache.expire("http://...") # expire cached result for a URL
  EarthTools.cache.expire(:all)         # expire all cached results

Do *not* include the prefix when passing a URL to be expired. Expiring `:all` will only expire keys with the configured prefix (won't kill every entry in your key/value store).

## Error handling

By default Earth Tools will rescue any exceptions raised by calls to the geocoding service and return an empty array (using warn() to inform you of the error). You can override this and implement custom error handling for certain exceptions by using the `:always_raise` option:

  EarthTools::Configuration.always_raise = [SocketError, TimeoutError]

## Known issues

None, right now.  Please post any issues to the [issues queue on github](https://github.com/mckramer/earth_tools/issues).

## Future

I would love to see this functionality brought into the `geocoder` gem in the future.

# License and attributions

This gem's structure and design borrows heavily from `geocoder`, so thanks to its author.  Find me on twitter [@maxckramer](https://twitter.com/maxckramer).