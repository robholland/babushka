module Babushka
  class DepPool

    attr_accessor :skipped_count

    def initialize
      clear!
      @skipped_count = 0
    end

    def count
      @dep_hash.length
    end
    
    def names
      @dep_hash.keys
    end
    def deps
      @dep_hash.values
    end
    def for spec
      spec.respond_to?(:name) ? @dep_hash[spec.name] : @dep_hash[spec]
    end

    def clear!
      @dep_hash = {}
    end
    def uncache!
      deps.each {|dep| dep.send :uncache! }
    end

    def register dep
      raise "There is already a registered dep called '#{dep.name}'." if @dep_hash.has_key?(dep.name)
      @dep_hash[dep.name] = dep
    end

  end
end
