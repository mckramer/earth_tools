require 'rest_client'
require 'xmlsimple'
require 'earth_tools/configuration'

module EarthTools
  module Lookup
    
    ##
    # Base lookup object.
    #
    class Base
      
      ##
      # Query the Earth Tools service and return a EarthTools::Result object.
      # @return [EarthTools::Result, nil] the results object
      def search(*options)
        begin
          Timeout::timeout(EarthTools::Configuration.timeout) do
            uri = query(options)
            if cache && results = cache[uri]
              # Boom, cached
            else
              # Not cached, so go get the data
              raw_results = retrieve(uri)
              results = parse_xml(raw_results)
              # Save results to cache, if available
              cache(uri, results) if cache && results
            end
            results
          end
        rescue Timeout::Error => err
          raise_error(err) or warn "Earth Tools API took too long to respond. See EarthTools::Configuration to set the timeout time (currently set to #{EarthTools::Configuration.timeout} seconds)."
        end
      end
      
      private
      
      ##
      # The base URL for the web service endpoint (protocol and server).
      # @return [String] the base URL
      def base_service_url
        "http://www.earthtools.org"
      end
      
      ##
      # Gets the cache.
      # @return [EarthTools::Cache] the cache
      def cache
        EarthTools::Configuration.cache
      end
      
      ##
      # URL to use for querying the geocoding engine.
      # @return [String] the url
      def query(*options)
        base_service_url + query_base + options.join('/')
        # ([base_service_url, query_base] + options).join('/')
      end
      
      ##
      # Handle XML results by validating them.
      # @param raw_xml the xml to parse
      # @return [Height, SunriseSunset, TimeZone] the result
      def parse_xml(raw_xml)
        xml = XmlSimple.xml_in( raw_xml, { 'ForceArray' => false } )
        if xml['location']
          result_class.new(xml)
        else
          warn "Invalid request."
        end
      end
      
      ##
      # Handles running query.
      # @return [xml] the results
      def retrieve(query)
        RestClient.proxy = EarthTools::Configuration.proxy if EarthTools::Configuration.proxy
        RestClient.get query
      end
      
      ##
      # Raise exception if configuration specifies it should be raised.
      # @return [boolean] false, if exception not raised
      def raise_error(error, message = nil)
        raise error, message if EarthTools::Configuration.always_raise.include?( error.is_a?(Class) ? error : error.class )
        false
      end
      
      ##
      # The base of the query for the function.
      # @return [String] the base of the query
      # @throws NotImplementedError when child class does not implement method
      def query_base
        raise NotImplementedError
      end
      
      ##
      # The class for the result.
      # @return [EarthTools::Result::Height, EarthTools::Result::SunriseSunset, EarthTools::Result::TimeZone] the result class
      def result_class
        EarthTools::Result.const_get(self.class.to_s.split(":").last)
      end
    end
  end
end