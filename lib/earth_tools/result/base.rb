module EarthTools
  module Result
  
    ##
    # The base result object.
    # 
    # Contains shared domain fields.  Extended by different results.
    #
    class Base
      attr_accessor :data
      
      ##
      # Takes a hash of result data from a parsed Google result document.
      # @param [Object] the 
      def initialize(data)
        @data = data
      end
      
      ##
      # Get the geographical location
      # @return [Array] a two-element array: [latitude, longitude]
      def location
        [latitude, longitude]
      end
      
      ##
      # Get the latitude
      # See {http://en.wikipedia.org/wiki/Latitude}.
      # @return [Float] the latitude
      def latitude
        @data['location']['latitude'].to_f
      end
      
      ##
      # Get the longitude
      # See {http://en.wikipedia.org/wiki/Longitude}.
      # @return the longitude
      def longitude
        @data['location']['longitude'].to_f
      end
      
      ##
      # The version of the response format
      # @return [Float] the version
      def version
        @data['version'].to_f
      end
      
    end
  end
end