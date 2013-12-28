require 'singleton'
module EarthTools

  ##
  # This method can be used to change some functional aspects, like
  # the cache client or the units of calculations.
  # See {include:Configuration}.
  def self.configure(&block)
    if block_given?
      block.call(Configuration.instance)
    else
      Configuration.instance
    end
  end
  
  ##
  # The singleton that maintains the configuration settings for plugin.
  class Configuration
    include Singleton
    
    # The available options
    OPTIONS = [
      :timeout,
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
    
    ##
    # Sets the configuration options to the default values
    def set_defaults
      @timeout      = 3               # Geocoding service timeout (secs)
      @proxy        = nil             # HTTP proxy server (user:pass@host:port)
      @cache        = nil             # Cache object (must respond to #[], #[]=, #keys, and #delete)
      @cache_prefix = "earth_tools:"  # Prefix (string) to use for all cache keys
      
      # Exceptions that should not be rescued by default
      # (if you want to implement custom error handling);
      # supports SocketError and Timeout::Error
      @always_raise = []
      
      # Calculation options
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
      # Sets the configuration options to the default values
      def set_defaults
        instance.set_defaults
      end
    end
    
  end
end