module Triangular
  class Point
    
    attr_accessor :x, :y, :z
    
    def initialize(x, y, z)
      @x = x
      @y = y
      @z = z      
    end
    
    def to_s
      "#{@x.to_f} #{@y.to_f} #{@z.to_f}"
    end
    
    def self.parse(string)
      string.strip!
      match_data = string.match(self.pattern)
      
      self.new(match_data[:x].to_f, match_data[:y].to_f, match_data[:z].to_f)
    end
    
    def self.pattern
      /(?<x>-?\d+.\d+)\s(?<y>-?\d+.\d+)\s(?<z>-?\d+.\d+)/
    end
    
  end
end
