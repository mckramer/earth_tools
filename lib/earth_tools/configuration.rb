require 'singleton'
module EarthTools
  class Configuration
    include Singleton
    
    OPTIONS = [
      :timeout,
      :language,
      :secure,
      :proxy,
      :cache,
      :cache_prefix,
      :always_raise,
      :units
    ]
    
    attr_accessor *OPTIONS
    
    def initialize  # :nodoc
      set_defaults
    end

    # This method will set the configuration options to the default values
    def set_defaults
      @timeout      = 3               # geocoding service timeout (secs)
      @language     = :en             # ISO-639 language code
      @secure       = false           # use HTTPS for lookup requests? (if supported)
      @proxy        = nil             # HTTP proxy server (user:pass@host:port)
      @cache        = nil             # cache object (must respond to #[], #[]=, and #keys)
      @cache_prefix = "earth_tools:"  # prefix (string) to use for all cache keys

      # exceptions that should not be rescued by default
      # (if you want to implement custom error handling);
      # supports SocketError and Errno::ETIMEDOUT
      @always_raise = []

      # calculation options
      @units     = :english # :metric or :english
    end
    

    # Delegates getters and setters for all configuration settings,
    # and +set_defaults+ to the singleton instance.
    instance_eval(OPTIONS.map do |option|
      o = option.to_s
      <<-EOS
      def #{o}
        instance.#{o}
      end

      def #{o}=(value)
        instance.#{o} = value
      end
      EOS
    end.join("\n\n"))

    class << self
      # This method will set the configuration options to the default values
      def set_defaults
        instance.set_defaults
      end
    end
    
  end
end