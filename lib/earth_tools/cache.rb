module EarthTools
  
  ##
  # The Earth Tools cache wrapper.
  #
  # Must respond to:
  # -> []   -- read
  # -> []=  -- write
  # -> del  -- delete
  # -> keys -- list of keys
  #
  class Cache
    
    ##
    # @constructor
    def initialize(store, prefix)
      @store = store
      @prefix = prefix
    end
    
    ##
    # Read from the cache.
    # @return the object saved in the cache
    def [](url)
      @store[key_for(url)]
    end
    
    ##
    # Write to the cache.
    def []=(url, value)
      @store[key_for(url)] = value
    end
    
    ##
    # Delete cache entry for given URL,
    # or pass <tt>:all</tt> to clear all URLs.
    def expire(url)
      if url == :all
        urls.each{ |u| expire(u) }
      else
        @store.send(@store.respond_to?(:del) ? :del : :delete, key_for(url))
      end
    end
    
  private
    
    attr_reader :prefix, :store
    
    ##
    # Cache key for a given URL.
    # @return [String] the cache key
    def key_for(url)
      [@prefix, url].join
    end
    
    ##
    # Array of keys with the currently configured prefix
    # that have non-nil values.
    # @return [Array] the list of keys
    def keys
      @store.keys.select{ |k| k.match /^#{@prefix}/ and cleave(@store[k]) }
    end
    
    ##
    # Array of cached URLs.
    # @return [Array] the list of cached URLs
    def urls
      keys.map{ |k| k[/^#{@prefix}(.*)/, 1] }
    end
    
    ##
    # Convert empty string to nil.
    # (Some key/value stores return empty string instead of nil.)
    # @return [Object, nil] the object or nil
    def cleave(value)
      value == "" ? nil : value
    end
    
  end
end