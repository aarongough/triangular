module Triangular
  class Vertex
    
    attr_accessor :x, :y, :z
    
    def initialize(x, y, z)
      @x = x
      @y = y
      @z = z      
    end
    
    def self.parse(string)
      string.strip!
      match_data = string.match(self.pattern)
      
      self.new(match_data[1].to_f, match_data[2].to_f, match_data[3].to_f)
    end
    
    def self.pattern
      /vertex\s+(-?\d+.\d+)\s(-?\d+.\d+)\s(-?\d+.\d+)/
    end
    
  end
end
