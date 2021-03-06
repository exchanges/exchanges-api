module Exchanges
  class Cache

    def initialize
      @store = Exchnages.cache
      @prefix = Exchnages.cache_prefix
    end

    def [](url)
      interpret case
        when store.respond_to?(:[])
          store[key_for(url)]
        when store.respond_to?(:get)
          store.get key_for(url)
        when store.respond_to?(:read)
          store.read key_for(url)
      end
    end

    def []=(url, value)
      case
        when store.respond_to?(:[]=)
          store[key_for(url)] = value
        when store.respond_to?(:set)
          store.set key_for(url), value
        when store.respond_to?(:write)
          store.write key_for(url), value
      end
    end

    def expire(url)
      if url == :all
        urls.each{ |u| expire(u) }
      else
        expire_single_url(url)
      end
    end


    private

    def prefix; @prefix; end
    def store; @store; end

    def key_for(url)
      [prefix, url].join
    end

    def keys
      store.keys.select{ |k| k.match(/^#{prefix}/) and interpret(store[k]) }
    end

    def urls
      keys.map{ |k| k[/^#{prefix}(.*)/, 1] }
    end

    def interpret(value)
      value == "" ? nil : value
    end

    def expire_single_url(url)
      key = key_for(url)
      store.respond_to?(:del) ? store.del(key) : store.delete(key)
    end
  end
end
