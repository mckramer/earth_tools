require 'rest_client'
require 'xmlsimple'
require 'earth_tools/configuration'

module EarthTools
  module Lookup
    class Base
      
      ##
      # Query the Earth Tools service and return a EarthTools::Result object.
      # Returns +nil+ on timeout or error.
      #
      def search(*options)
        begin
          raw_results = retrieve(query(options))
          parse_results(raw_results, :xml)
        rescue Errno::ETIMEDOUT => err
          raise_error(err) or warn "Earth Tools API took too long to respond. " 
            + "See EarthTools::Configuration to set the timeout time (currently set to #{EarthTools::Configuration.timeout} seconds."
        end
      end
    
      private
      
      ##
      # The base url for the web service endpoint (protocol and server)
      # 
      def base_service_url
        "#{protocol}://www.earthtools.org"
      end
      
      ##
      # Protocol to use for communication with geocoding services.
      # Set in configuration but not available for every service.
      #
      def protocol
        "http" + (EarthTools::Configuration.secure ? "s" : "")
      end
      
      ##
      # URL to use for querying the geocoding engine.
      #
      def query(*options)
        base_service_url + query_base + options.join('/')
      end
      
      ##
      # Parse results depending on if xml or json
      #
      def parse_results(raw_results, type)
        case type
        when :xml
          parse_xml(XmlSimple.xml_in(raw_results))
        when :json
          raise UnsupportedOperationError, "JSON is not supported"
        end
      end
      
      ##
      # Handle XML results by validating them
      #
      def parse_xml(xml)
        if xml['location']
          result_class.new(xml)
        else
          warn "Invalid request."
          puts xml
        end
      end
      
      ##
      # Handles running query
      #
      def retrieve(query)
        RestClient.proxy = EarthTools::Configuration.proxy if EarthTools::Configuration.proxy
        puts "Trying to connect to endpoint(#{query})"
        puts "Using proxy (#{RestClient.proxy})" if RestClient.proxy
        RestClient.get query
      end
      
      ##
      # Raise exception if configuration specifies it should be raised.
      # Return false if exception not raised.
      #
      def raise_error(error, message = nil)
        if EarthTools::Configuration.always_raise.include?( error.is_a?(Class) ? error : error.class )
          raise error, message
        else
          false
        end
      end
      
      ##
      # 
      #
      def query_base
        raise NotImplementedError
      end
      
      def result_class
        EarthTools::Result.const_get(self.class.to_s.split(":").last)
      end
    end
  end
end