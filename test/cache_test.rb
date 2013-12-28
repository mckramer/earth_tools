# encoding: utf-8

require 'test_helper'
require 'earth_tools'
require 'earth_tools/cache'

##
# Tests for the Cache.
class CacheTest < MiniTest::Unit::TestCase
  
  def setup
    @raw_cache = {}
    @cache = EarthTools::Cache.new(@raw_cache, 'earth_tools:')
  end
  
  def test_store_and_retrieve_from_cache
    @cache['test/1'] = :data
    
    assert_equal :data, @cache['test/1'], 'The cache was not stored properly.'
  end
  
  def test_remove_single_url
    @cache['test/1'] = :data
    @cache['test/2'] = :data
    
    @cache.expire('test/1')
    
    assert_nil @cache['test/1'], 'The cache should have deleted entry.'
    assert_equal :data, @cache['test/2'], 'The cache should not have deleted entry.'
  end
  
  def test_remove_all_prefixed_urls
    @raw_cache['test']        = :data
    @raw_cache['other:test']  = :data
    @cache['test/1'] = :data
    @cache['test/2'] = :data
    @cache['test/3'] = :data
    
    @cache.expire(:all)
    assert_equal :data, @raw_cache['test'], 'The cache should not affect non-prefixed entries.'
    assert_equal :data, @raw_cache['other:test'], 'The cache should not affect non-prefixed entries.'
    assert_nil @cache['test/1'], 'The cache should be empty of prefixed entries.'
    assert_nil @cache['test/2'], 'The cache should be empty of prefixed entries.'
    assert_nil @cache['test/3'], 'The cache should be empty of prefixed entries.'
  end
  
end