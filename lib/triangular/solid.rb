module Triangular
  class Solid
    
    attr_accessor :name, :facets
    
    def initialize(name, *args)
      @name = name
      @facets = args
    end
    
    def self.parse(string)
      match_data = string.match(/\s* solid\s+ (?<name> [a-zA-Z0-9\-\_\.]+)?/x)
      
      solid = self.new(match_data[:name])
      
      string.gsub(Facet.pattern) do |facet|
        solid.facets << Facet.parse(facet)
      end
      
      solid
    end
  end
end
