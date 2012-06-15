module EarthTools
  module Result
  
    ##
    #
    #
    class Base
      attr_accessor :data

      ##
      # Takes a hash of result data from a parsed Google result document.
      #
      def initialize(data)
        @data = data
      end

      ##
      # Get the geographical location
      # @returns [Array] a two-element array: [latitude, longitude]
      def location
        [latitude, longitude]
      end

      ##
      # Get the latitude
      # See {http://en.wikipedia.org/wiki/Latitude}.
      # @returns [Float] the latitude
      def latitude
        @data['latitude'].to_f
      end

      ##
      # Get the longitude
      # See {http://en.wikipedia.org/wiki/Longitude}.
      # @returns the longitude
      def longitude
        @data['longitude'].to_f
      end
      
      ##
      # The version of the response format
      # @returns [Float] the version
      def version
        @data['version'].to_f
      end

    end
  end
end