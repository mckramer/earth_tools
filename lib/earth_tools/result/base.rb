module EarthTools
  module Result
    class Base
      attr_accessor :data

      ##
      # Takes a hash of result data from a parsed Google result document.
      #
      def initialize(data)
        @data = data
      end

      ##
      # A two-element array: [latitude, longitude].
      #
      def location
        [latitude, longitude]
      end

      ##
      # 
      #
      def latitude
        @data['latitude'].to_f
      end

      ##
      # 
      #
      def longitude
        @data['longitude'].to_f
      end
      
      def version
        @data['version']
      end

    end
  end
end