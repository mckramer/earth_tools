# earth_tools

[![Build Status](https://secure.travis-ci.org/mckramer/earth_tools.png?branch=master)][travis] [![Dependency Status](https://gemnasium.com/mckramer/earth_tools.png?travis)][gemnasium]

`earth_tools` is a wrapper around the wonderful [earthtools.org webservices](http://www.earthtools.org/webservices.htm), which allows you to determine the sea level height, time zone, and surise/sunset times from a set of coordinates.

## Compatibility

* Supports Ruby 1.9.2

Will be testing on other versions in the future.

## Installation

Add to your Gemfile:

  `gem "earth_tools"`

and then bundle your gemfile:

  `bundle install`

## API

The run down of the 3 major functions available

### Time zone

  result = EarthTools::time_zone(latitude, longitude)
  
  # Example
  result = EarthTools::time_zone(latitude, longitude) # New York City
  result.utc_time # returns ""

### Height above/below sea level

  result = EarthTools::time_zone(latitude, longitude)
  
  # Example
  result = EarthTools::time_zone(latitude, longitude) # New York City
  result.utc_time # returns ""

### Sunrise/sunset times

  result = EarthTools::time_zone(latitude, longitude)
  
  # Example
  result = EarthTools::sunrise_sunset(latitude, longitude) # New York City
  result.utc_time # returns ""

Earth Tool API restrictions
---------------------------

### Limits

Earth Tools imposes some [usage restrictions](http://www.earthtools.org/webservices.htm#usage) that are copies below (these restrictions may be out of date, so please check the website):

1. You must not make more than one request per second to these webservices.
2. You must cache results if you believe that you will need to make another identical request within any 24-hour period.
3. You must delete any cached data when you no longer need it and in any case after 14 days. You should then make a new request for the data in line with the previous two rules. If you wish to keep access to data I am able to license the data for use in this way.

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

Error handling
--------------

By default Earth Tools will rescue any exceptions raised by calls to the geocoding service and return an empty array (using warn() to inform you of the error). You can override this and implement custom error handling for certain exceptions by using the `:always_raise` option:

  EarthTools::Configuration.always_raise = [SocketError, TimeoutError]

Known issues
------------

None, right now.  Please post any issues to the [issues queue on github](https://github.com/mckramer/earth_tools/issues).

License and attrributions 
=========================

This gem's structure and design borrows heavily from `geocoder`.